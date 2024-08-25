//
//  ContentView.swift
//  WeatherApp
//
//  Created by Engy on 8/22/24.
//

import SwiftUI

import SwiftUI

struct MainScreenView: View {
    @State private var weather: WeatherData?
    @State  var isDay: Bool
    @State private var searchText: String = ""

    var body: some View {
        NavigationStack {
            ZStack {
                if let weather = weather {
                    BackgroundView(isDay: isDay)
                    ScrollView {
                        VStack {
                            SearchBar(searchText: $searchText, isConditionMet: isDay)

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
            .onSubmit {
                loadData()
                searchText = ""

            }
        }
    }

    private func loadData() {
        let location = searchText.isEmpty ? "30.0715495,31.0215953" : searchText
        WeatherService.fetchWeather(for: location) { fetchedWeather in
            if let weatherData = fetchedWeather {
                DispatchQueue.main.async {
                    weather = weatherData
                    isDay = weatherData.current.isDay == 1
                }
            }
        }
    }
}



struct MainScreenView_Previews: PreviewProvider {
    static var previews: some View {
        MainScreenView(isDay:true)
    }
}
