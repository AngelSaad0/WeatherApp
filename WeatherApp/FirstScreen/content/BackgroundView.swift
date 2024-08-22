//
//  BackgroundView.swift
//  WeatherApp
//
//  Created by Engy on 8/22/24.
//

import SwiftUI
struct BackgroundView: View {
    let isDay:Bool

    var body: some View {
        if isDay {
            Image(.morningBackground)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .overlay(
                    Color.black
                        .opacity(0)
                        .edgesIgnoringSafeArea(.all)
                )


        } else{
            Image(.nightBackground)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea(.all)
                .overlay(
                    Color.black
                        .opacity(0.4)
                        .edgesIgnoringSafeArea(.all)
                )

        }


    }
}

#Preview {
    BackgroundView(isDay: false)
}
