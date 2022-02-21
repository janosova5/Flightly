//
//  UniqueDestinationFilter.swift
//  Flightly
//
//  Created by Lenka Janosova on 21/02/2022.
//

import Foundation

final class UniqueDestinationFilter {
    private let repository: DisplayedDestinationsRepository

    init(repository: DisplayedDestinationsRepository) {
        self.repository = repository
    }

    private let numberOfFlightsToDisplay = 5

    func flightsToDisplay(from flightList: FlightDataList, for date: DateComponents) -> ArraySlice<Flight> {
        let newFlights = flightList.data.prefix(numberOfFlightsToDisplay)

        if let displayedFlights = repository.getData() {
            if date != displayedFlights.dateOfUpdate {
                let flightsToDisplay = flightList.data
                    .filter { !displayedFlights.destinationsCityCodes.contains($0.cityCodeTo) }
                    .prefix(numberOfFlightsToDisplay)

                saveDisplayedFlights(flightsToDisplay, date)
                return flightsToDisplay
            } else {
                updateDisplayedFlights(with: newFlights, displayedFlights, date)
                return newFlights
            }
        }
        saveDisplayedFlights(newFlights, date)
        return newFlights
    }

    private func saveDisplayedFlights(_ data: ArraySlice<Flight>, _ date: DateComponents) {
        let cityToCodes = data.map { $0.cityCodeTo }
        let displayedFlightsModel = DisplayedFlightsModel(dateOfUpdate: date, destinationsCityCodes: cityToCodes)
        repository.save(displayedFlightsModel)
    }

    private func updateDisplayedFlights(with newFlights: ArraySlice<Flight>, _ displayedFlights: DisplayedFlightsModel, _ date: DateComponents) {
        let newDestinationCodes = newFlights
            .filter{ !displayedFlights.destinationsCityCodes.contains($0.cityCodeTo) }
            .map { $0.cityCodeTo }
        
        if !newDestinationCodes.isEmpty {
            let updatedFlightsModel = DisplayedFlightsModel(dateOfUpdate: date, destinationsCityCodes: newDestinationCodes)
            repository.save(updatedFlightsModel)
        }
    }
}
