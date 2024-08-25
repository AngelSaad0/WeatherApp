//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by Engy on 8/22/24.
//

import SwiftUI

@main
struct WeatherAppApp: App {
//    init() {
//            WeatherService.fetchWeather { weather in
//                if let weather = weather {
//                    print("Weather data: \(weather)")
//                } else {
//                    print("Failed to fetch weather data.")
//                }
//            }
//        }
    var body: some Scene {
        WindowGroup {
            MainScreenView()
        }
    }
}
