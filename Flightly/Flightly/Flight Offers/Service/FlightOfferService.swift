//
//  FlightOfferService.swift
//  Flightly
//
//  Created by Lenka Janosova on 19/02/2022.
//

import Foundation
import Combine

final class FlightOfferService {
    
    private var components: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.skypicker.com"
        components.path = "/flights"

        components.queryItems = [
            URLQueryItem(name: "fly_from", value: "prague_cz"),
            URLQueryItem(name: "to", value: "anywhere"),
            URLQueryItem(name: "locale", value: "en"),
            URLQueryItem(name: "sort", value: "price"),
            URLQueryItem(name: "partner", value: "skypicker"),
        ]

        return components
    }

    func loadFlights(startingByDate: String, endingByDate: String) -> AnyPublisher<FlightDataList, KiwiError> {
        let datesQueryItems = [
            URLQueryItem(name: "dateFrom", value: startingByDate),
            URLQueryItem(name: "dateTo", value: endingByDate)
        ]
        var updatedComponents = components
        updatedComponents.queryItems?.append(contentsOf: datesQueryItems)

        guard let url = updatedComponents.url else {
            return Fail(error: .sessionFailed(error: URLError(.badURL)))
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
        }

        return NetworkService.request(url: url)
    }
}
