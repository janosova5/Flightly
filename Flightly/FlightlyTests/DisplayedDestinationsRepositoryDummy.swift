//
//  DisplayedDestinationsRepositoryDummy.swift
//  FlightlyTests
//
//  Created by Lenka Janosova on 21/02/2022.
//

@testable import Flightly

final class DisplayedDestinationsRepositoryDummy: DisplayedDestinationsRepository {

    var flights: DisplayedFlightsModel?

    func save(_ value: DisplayedFlightsModel) {
        flights = value
    }
    
    func getData() -> DisplayedFlightsModel? {
        return flights
    }
}
