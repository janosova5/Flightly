//
//  DisplayedFlightsViewModel.swift
//  Flightly
//
//  Created by Lenka Janosova on 20/02/2022.
//

import Foundation

struct DisplayedFlightsModel: Codable {
    var dateOfUpdate: DateComponents?
    var destinationsCityCodes: [String] = []
}
