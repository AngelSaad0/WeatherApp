//
//  ContentView.swift
//  WeatherApp
//
//  Created by Engy on 8/22/24.
//

import SwiftUI

struct MainScreenView: View {
    @State private var weather: WeatherData?
    @State private var isDay: Bool = true

    var body: some View {
        NavigationStack {
            ZStack {

                if let weather = weather {
                    BackgroundView(isDay: isDay)
                    ScrollView {
                        VStack {
                            TopSection(weather: weather)
                            Spacer()
                            MiddleSection(weather: weather)
                            Spacer().frame(height: 20)
                            BottomSection(weather: weather)
                        }
                    }
                } else {
                    Text("Wait for loading ...")
                }
            }
            .foregroundColor(isDay ? .black : .white)
            .onAppear(perform: loadData)
        }
    }

    private func loadData() {
        WeatherService.fetchWeather { fetchedWeather in
            if let weatherData = fetchedWeather {
                DispatchQueue.main.async {
                    weather = weatherData
                    isDay = weatherData.current.isDay == 1
                }
            }
        }
    }
}

#Preview {
    MainScreenView()
}
