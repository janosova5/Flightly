//
//  FlightListModel.swift
//  Flightly
//
//  Created by Lenka Janosova on 19/02/2022.
//

import Foundation

struct FlightDataList: Decodable {
    let currency: String
    let data: [Flight]
}

struct Flight: Decodable {
    let id: String
    let cityFrom: String
    let cityTo: String
    let countryFrom: Country
    let countryTo: Country
    let departureTime: Int
    let arrivalTime: Int
    let duration: String
    let price: Float

    enum CodingKeys: String, CodingKey {
        case id
        case cityFrom
        case cityTo
        case countryFrom
        case countryTo
        case departureTime = "dTime"
        case arrivalTime = "aTime"
        case duration = "fly_duration"
        case price
    }
}

struct Country: Decodable {
    let code: String
    let name: String
}
