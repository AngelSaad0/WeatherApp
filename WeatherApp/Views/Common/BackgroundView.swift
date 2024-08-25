//
//  BackgroundView.swift
//  WeatherApp
//
//  Created by Engy on 8/22/24.
//

import SwiftUI

struct BackgroundView: View {
    let isDay: Bool

    private var backgroundImage: Image {
        isDay ? Image(.morningBackground) : Image(.nightBackground)

    }

    private var overlayOpacity: Double {
        isDay ? 0 : 0.3

    }

    var body: some View {
        backgroundImage
            .resizable()
            .scaledToFill()
            .ignoresSafeArea()
            .overlay(
                Color.black
                    .opacity(overlayOpacity)
                    .edgesIgnoringSafeArea(.all)
            )
    }
}

#Preview {
    MainScreenView()
   // BackgroundView(isDay: true)
}
