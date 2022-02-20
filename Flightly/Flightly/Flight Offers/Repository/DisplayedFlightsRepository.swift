//
//  DisplayedFlightsRepository.swift
//  Flightly
//
//  Created by Lenka Janosova on 20/02/2022.
//

import Foundation

struct DisplayedFlightsRepository {
    static let key = "displayedFlights"

    static func save(_ value: DisplayedFlightsModel) {
         UserDefaults.standard.set(try? PropertyListEncoder().encode(value), forKey: key)
    }

    static func getData() -> DisplayedFlightsModel? {
        if let data = UserDefaults.standard.value(forKey: key) as? Data, let flightsData = try? PropertyListDecoder().decode(DisplayedFlightsModel.self, from: data) {
            return flightsData
        }
        return nil
    }
}
