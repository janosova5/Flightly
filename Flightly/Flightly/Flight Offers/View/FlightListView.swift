//
//  ContentView.swift
//  Flightly
//
//  Created by Lenka Janosova on 19/02/2022.
//

import SwiftUI

struct FlightListView: View {

    @ObservedObject private var viewModel = FlightListViewModel()
    private let toDisplay = 5

    var body: some View {
        // FIXME: layout
        NavigationView {
            List(viewModel.flightViewModelList.prefix(toDisplay), id: \.id) { flightVM in
                Text(flightVM.cityFrom + " - " + flightVM.cityTo)
                Text(flightVM.countryFromName + " - " + flightVM.countryToName)
                Text(flightVM.departureTimeFormatted + " - " + flightVM.arrivalTimeFormatted)
                Text(flightVM.duration)
                Text(flightVM.priceFormatted)
            }.onAppear {
                self.viewModel.loadFlights()
            }.navigationBarTitle("Cheapest flights this month")
        }
    }
}

struct FlightList_Previews: PreviewProvider {
    static var previews: some View {
        FlightListView()
    }
}
