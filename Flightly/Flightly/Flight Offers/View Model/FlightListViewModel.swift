//
//  FlightViewModel.swift
//  Flightly
//
//  Created by Lenka Janosova on 19/02/2022.
//

import Foundation
import Combine

class FlightListViewModel: ObservableObject {
    private let flightOfferService = FlightOfferService()

    private var formattedDates: (String, String) {
        guard let interval = Calendar.current.dateInterval(of: .month, for: .now) else { return ("", "") }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return (dateFormatter.string(from: interval.start), dateFormatter.string(from: interval.end))
    }

    @Published var flightViewModelList: [FlightViewModel] = []

    var cancellable: AnyCancellable?

    func loadFlights() {
        cancellable = flightOfferService.loadFlights(
            startingByDate: formattedDates.0, endingByDate: formattedDates.1
        ).sink(
            receiveCompletion: { _ in },
            receiveValue: { [weak self] flightDataList in
                self?.flightViewModelList = flightDataList.data.map {
                    FlightViewModel(flight: $0, currency: flightDataList.currency)
                }
            }
        )
    }
}
