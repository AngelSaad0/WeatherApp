//
//  BottomSection.swift
//  WeatherApp
//
//  Created by Engy on 8/22/24.
//

import SwiftUI

struct BottomSection: View {
    var weather: WeatherData

    var body: some View {
        VStack {
            HStack {
                InfoBlock(title: "Visibility", value: "\(weather.current.visKM) km")
                InfoBlock(title: "Humidity", value: "\(weather.current.humidity)%")
            }
            .padding(.bottom)

            HStack {
                InfoBlock(title: "Feels Like", value: "\(weather.current.feelslikeC)°C")
                InfoBlock(title: "Pressure", value: "\(weather.current.pressureMB) mb")
            }
        }
        .frame(width: UIScreen.main.bounds.width)
       
    }
}

struct InfoBlock: View {
    var title: String
    var value: String

    var body: some View {
        VStack {
            Text(title)
                .font(.caption)
            Text(value)
                .font(.largeTitle)
                .fontWeight(.medium)
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    MainScreenView()
}
