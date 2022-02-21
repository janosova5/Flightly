//
//  ErrorView.swift
//  Flightly
//
//  Created by Lenka Janosova on 20/02/2022.
//

import Foundation
import SwiftUI

struct ErrorView: View {

    var message: String

    init(message: String) {
        self.message = message
    }

    var body: some View {
        ZStack {
            Color(.systemBackground)
                .ignoresSafeArea()
                .opacity(0.7)
            Text(message).font(.headline)
        }
    }
}
