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
        ZStack {
            NavigationView {
                VStack(alignment: .leading) {
                    Text("Check the cheapest flights from Prague this month")
                        .font(.subheadline)
                        .padding(.leading)
                    List(viewModel.flightViewModelList.prefix(toDisplay), id: \.id) { flightVM in
                        FlightCell(flightVM: flightVM)
                    }.onAppear {
                        viewModel.loadFlights()
                    }.navigationBarTitle("Where to?")
                }.background(.cyan)
            }
            if viewModel.isLoading {
                LoadingView()
            }
            if let error = viewModel.error {
                ErrorView(message: error.message())
            }
        }
    }
}

struct FlightList_Previews: PreviewProvider {
    static var previews: some View {
        FlightListView()
    }
}
