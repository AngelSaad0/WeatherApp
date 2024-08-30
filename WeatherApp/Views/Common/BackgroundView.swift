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
        isDay ? 0.0: 0.2
    }

    var body: some View {
        ZStack {
            backgroundImage
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .transition(.opacity)

            Color.black
                .opacity(overlayOpacity)
                .edgesIgnoringSafeArea(.all)
                .animation(.easeInOut(duration: 1.0), value: overlayOpacity)
        }
        .animation(.easeInOut(duration: 1.0), value: isDay) 
    }
}

//#Preview {
   // MainScreenView(isDay: false)
    // BackgroundView(isDay: true)
//}
