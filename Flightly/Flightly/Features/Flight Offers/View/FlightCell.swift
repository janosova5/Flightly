//
//  FlightCell.swift
//  Flightly
//
//  Created by Lenka Janosova on 19/02/2022.
//

import SwiftUI

struct FlightCell: View {
    var flightVM: FlightViewModel

    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: .vSpaceSmall) {
                HStack(alignment: .center) {
                    Image("plane")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: CGSize.smallIcon.width, height: CGSize.smallIcon.height, alignment: .center)
                    Text(flightVM.destinationFrom)
                        .font(.headline)
                    Spacer()
                    Image("right-arrow")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: CGSize.arrowIcon.width, height: CGSize.arrowIcon.height, alignment: .center)
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
            HStack(alignment: .center, spacing: .hSpaceNormal) {
                VStack(alignment: .leading) {
                    HStack(alignment: .center, spacing: .hSpaceSmall) {
                        Image("duration")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: CGSize.smallIcon.width, height: CGSize.smallIcon.height, alignment: .leading)
                        Text(flightVM.duration)
                    }
                    HStack(alignment: .center, spacing: .hSpaceSmall) {
                        Image("price")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: CGSize.smallIcon.width, height: CGSize.smallIcon.height, alignment: .leading)
                        Text(flightVM.priceFormatted)
                            .font(.headline)
                    }
                }.padding(.leading)
                if let imageData = flightVM.destinationImageData, let image = UIImage(data: imageData) {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(.imageCornerRadius)
                        .padding([.top, .bottom, .leading])
                }
            }
        }
    }
}
