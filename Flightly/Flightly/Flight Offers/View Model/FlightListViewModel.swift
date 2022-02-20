//
//  FlightViewModel.swift
//  Flightly
//
//  Created by Lenka Janosova on 19/02/2022.
//

import Foundation
import Combine

final class FlightListViewModel: ObservableObject {
    private let today = Calendar.current.dateComponents([.day, .month, .year], from: .now)
    private let numberOfFlightsToDisplay = 5

    private struct DepartureInterval {
        let startDate: String
        let endDate: String
    }

    private var departureInterval: DepartureInterval {
        guard let interval = Calendar.current.dateInterval(of: .month, for: .now) else {
            return DepartureInterval(startDate: "", endDate: "")
        }
        let serviceDateFormatter = DateFormatter()
        serviceDateFormatter.dateFormat = "dd/MM/yyyy"
        return DepartureInterval(
            startDate: serviceDateFormatter.string(from: interval.start),
            endDate: serviceDateFormatter.string(from: interval.end)
        )
    }

    private let flightOfferService = FlightOfferService()

    @Published var flightViewModelList: [FlightViewModel] = []
    @Published var error: KiwiError?

    var cancellable: AnyCancellable?
    var isLoading: Bool = true

    func loadFlights() {
        cancellable = flightOfferService.loadFlights(
            startingByDate: departureInterval.startDate, endingByDate: departureInterval.endDate
        ).sink(
            receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.error = error
                    self?.isLoading = false
                case .finished:
                    print("Publisher is finished")
                }
            },
            receiveValue: { [weak self] flightDataList in
                self?.handleResult(with: flightDataList)
                self?.isLoading = false
            }
        )
    }

    private func handleResult(with result: FlightDataList) {
        let flightsToDisplay = flightsToDisplay(from: result)
        flightViewModelList = flightsToDisplay.map {
            FlightViewModel(
                flight: $0,
                currency: result.currency,
                imageData: downloadImage(for: $0.cityTo.lowercased() + "_" + $0.countryTo.code.lowercased())
            )
        }
    }

    private func downloadImage(for destinationString: String) -> Data? {
        let baseUrl = "https://images.kiwi.com/photos/600x330/"
        if let url = URL(string: baseUrl + destinationString + ".jpg"), let data = try? Data(contentsOf: url) {
            return data
        }
        if let url = URL(string: baseUrl + "photos.jpg"), let data = try? Data(contentsOf: url) {
            return data
        }
        return nil
    }

    private func flightsToDisplay(from flightList: FlightDataList) -> ArraySlice<Flight> {
        let newFlights = flightList.data.prefix(numberOfFlightsToDisplay)
        
        if let displayedFlights = DisplayedFlightsRepository.getData() {
            if today != displayedFlights.dateOfUpdate {
                let flightsToDisplay = flightList.data
                    .filter { !displayedFlights.destinationsCityCodes.contains($0.cityCodeTo) }
                    .prefix(numberOfFlightsToDisplay)

                saveDisplayedFlights(flightsToDisplay)
                return flightsToDisplay
            } else {
                updateDisplayedFlights(with: newFlights, displayedFlights)
                return newFlights
            }
        }
        saveDisplayedFlights(newFlights)
        return newFlights
    }

    private func saveDisplayedFlights(_ data: ArraySlice<Flight>) {
        let cityToCodes = data.map { $0.cityCodeTo }
        let displayedFlightsModel = DisplayedFlightsModel(dateOfUpdate: today, destinationsCityCodes: cityToCodes)
        DisplayedFlightsRepository.save(displayedFlightsModel)
    }

    private func updateDisplayedFlights(with newFlights: ArraySlice<Flight>, _ displayedFlights: DisplayedFlightsModel) {
        let newDestinationCodes = newFlights
            .filter{ !displayedFlights.destinationsCityCodes.contains($0.cityCodeTo) }
            .map { $0.cityCodeTo }
        
        if !newDestinationCodes.isEmpty {
            let updatedFlightsModel = DisplayedFlightsModel(dateOfUpdate: today, destinationsCityCodes: newDestinationCodes)
            DisplayedFlightsRepository.save(updatedFlightsModel)
        }
    }
}
