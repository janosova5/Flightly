//
//  FlightViewModel.swift
//  Flightly
//
//  Created by Lenka Janosova on 19/02/2022.
//

import Foundation

struct FlightViewModel {
    private var flight: Flight
    private var currency: String

    init(flight: Flight, currency: String) {
        self.flight = flight
        self.currency = currency
    }

    var id: String {
        return flight.id
    }

    var cityFrom: String {
        return flight.cityFrom
    }

    var cityTo: String {
        return flight.cityTo
    }

    var countryFromName: String {
        return flight.countryFrom.name
    }

    var countryToName: String {
        return flight.countryTo.name
    }

    var duration: String {
        return flight.duration
    }

    var departureTimeFormatted: String {
        return String(flight.departureTime) // FIXME: format time
    }

    var arrivalTimeFormatted: String {
        return String(flight.arrivalTime) // FIXME: format time
    }

    var priceFormatted: String {
        return String(flight.price) + " " + currency
    }
}
