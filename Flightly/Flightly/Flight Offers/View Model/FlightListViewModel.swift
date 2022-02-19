//
//  FlightViewModel.swift
//  Flightly
//
//  Created by Lenka Janosova on 19/02/2022.
//

import Foundation
import Combine

final class FlightListViewModel: ObservableObject {
    private let flightOfferService = FlightOfferService()

    private var formattedDates: (String, String) {
        guard let interval = Calendar.current.dateInterval(of: .month, for: .now) else { return ("", "") }
        let serviceDateFormatter = DateFormatter()
        serviceDateFormatter.dateFormat = "dd/MM/yyyy"
        return (serviceDateFormatter.string(from: interval.start), serviceDateFormatter.string(from: interval.end))
    }

    @Published var flightViewModelList: [FlightViewModel] = []

    var cancellable: AnyCancellable?
    var isLoading: Bool = true

    func loadFlights() {
        cancellable = flightOfferService.loadFlights(
            startingByDate: formattedDates.0, endingByDate: formattedDates.1
        ).sink(
            receiveCompletion: { _ in },
            receiveValue: { [weak self] flightDataList in
                self?.flightViewModelList = flightDataList.data.map {
                    FlightViewModel(flight: $0, currency: flightDataList.currency)
                }
                self?.isLoading = false
            }
        )
    }
}
