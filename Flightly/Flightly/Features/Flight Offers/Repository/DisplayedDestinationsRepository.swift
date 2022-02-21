//
//  DisplayedFlightsRepository.swift
//  Flightly
//
//  Created by Lenka Janosova on 20/02/2022.
//

import Foundation

protocol DisplayedDestinationsRepository {
    func save(_ value: DisplayedFlightsModel)
    func getData() -> DisplayedFlightsModel?
}

final class DisplayedDestinationsRepositoryImpl {
    let key = "displayedFlights"
}

extension DisplayedDestinationsRepositoryImpl: DisplayedDestinationsRepository {
    func save(_ value: DisplayedFlightsModel) {
         UserDefaults.standard.set(try? PropertyListEncoder().encode(value), forKey: key)
    }

    func getData() -> DisplayedFlightsModel? {
        if let data = UserDefaults.standard.value(forKey: key) as? Data,
           let flightsData = try? PropertyListDecoder().decode(DisplayedFlightsModel.self, from: data) {
            return flightsData
        }
        return nil
    }
}
