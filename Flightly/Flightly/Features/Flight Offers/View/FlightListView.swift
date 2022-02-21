//
//  ContentView.swift
//  Flightly
//
//  Created by Lenka Janosova on 19/02/2022.
//

import SwiftUI

struct FlightListView: View {

    @ObservedObject private var viewModel: FlightListViewModel

    init(viewModel: FlightListViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        ZStack {
            NavigationView {
                VStack(alignment: .leading) {
                    Text("Looking for a break under the 100€ from Prague next days? Check this out.")
                        .font(.subheadline)
                        .padding(.leading)
                    List(viewModel.flightViewModelList, id: \.id) { flightVM in
                        FlightCell(flightVM: flightVM)
                    }.onAppear {
                        viewModel.loadFlights()
                    }.navigationBarTitle("Where to?")
                        .listStyle(.insetGrouped)
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

//struct FlightList_Previews: PreviewProvider {
//    static var previews: some View {
//        FlightListView()
//    }
//}
