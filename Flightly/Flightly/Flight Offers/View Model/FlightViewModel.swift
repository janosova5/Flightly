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

    private var displayDateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy, H:mm"
        return dateFormatter
    }

    init(flight: Flight, currency: String) {
        self.flight = flight
        self.currency = currency
    }

    var id: String {
        return flight.id
    }

    var destinationFrom: String {
        return flight.cityFrom + " (" + flight.countryFrom.code + ")"
    }

    var destinationTo: String {
        return flight.cityTo + " (" + flight.countryTo.code + ")"
    }

    var duration: String {
        return flight.duration
    }

    var departureTimeFormatted: String {
        let timeInterval = TimeInterval(flight.departureTime)
        let date = Date(timeIntervalSince1970: timeInterval)
        return displayDateFormatter.string(from: date)
    }

    var arrivalTimeFormatted: String {
        let timeInterval = TimeInterval(flight.arrivalTime)
        let date = Date(timeIntervalSince1970: timeInterval)
        return displayDateFormatter.string(from: date)
    }

    var priceFormatted: String {
        return String(flight.price) + " " + currency
    }
}
