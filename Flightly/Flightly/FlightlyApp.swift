//
//  FlightlyApp.swift
//  Flightly
//
//  Created by Lenka Janosova on 19/02/2022.
//

import SwiftUI

@main
struct FlightlyApp: App {
    
    let service = FlightOfferService()
    let repository = DisplayedDestinationsRepositoryImpl()
    
    var body: some Scene {
        WindowGroup {
            FlightListView(viewModel: FlightListViewModel(
                flightOfferService: service,
                displayedFlightsRepository: repository)
            )
        }
    }
}
