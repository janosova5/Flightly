//
//  LoadingView.swift
//  Flightly
//
//  Created by Lenka Janosova on 19/02/2022.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .ignoresSafeArea()
                .opacity(0.7)
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .cyan))
                .scaleEffect(3)
        }
    }
}
