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
        NavigationView {
            VStack(alignment: .leading) {
                Text("Check the cheapest flights from Prague this month")
                    .font(.subheadline)
                    .padding(.leading)
                List(viewModel.flightViewModelList.prefix(toDisplay), id: \.id) { flightVM in
                    FlightCell(flightVM: flightVM)
                }.onAppear {
                    self.viewModel.loadFlights()
                }.navigationBarTitle("Flight offers")
            }.background(.cyan)
        }
    }
}

struct FlightCell: View {
    var flightVM: FlightViewModel

    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 8) {
                HStack(alignment: .center) {
                    Image("plane")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25, height: 25, alignment: .center)
                    Text(flightVM.destinationFrom)
                        .font(.headline)
                    Spacer()
                    Image("right-arrow")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 35, alignment: .center)
                    Spacer()
                    Text(flightVM.destinationTo)
                        .font(.headline)
                }
                HStack(alignment: .center) {
                    Text(flightVM.departureTimeFormatted)
                    Spacer()
                    Text(flightVM.arrivalTimeFormatted)
                }
            }
            HStack(alignment: .center, spacing: 16) {
                VStack(alignment: .leading) {
                    HStack(alignment: .center, spacing: 8) {
                        Image("duration")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 25, alignment: .center)
                        Text(flightVM.duration)
                    }
                    HStack(alignment: .center, spacing: 8) {
                        Image("price")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 25, alignment: .center)
                        Text(flightVM.priceFormatted)
                            .font(.headline)
                    }
                }
                Image("placeholder")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    .padding([.top, .bottom])
            }
        }
    }
}

struct FlightList_Previews: PreviewProvider {
    static var previews: some View {
        FlightListView()
    }
}
