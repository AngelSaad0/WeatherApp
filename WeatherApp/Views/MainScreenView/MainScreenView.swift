//
//  ContentView.swift
//  WeatherApp
//
//  Created by Engy on 8/22/24.
//
import SwiftUI

struct MainScreenView: View {
    @StateObject private var locationManager = LocationManager()
    @State private var weather: WeatherData?
    @State var isDay: Bool = true
    @State private var searchText: String = ""
    @State private var showSettingsAlert = false

    var body: some View {
        NavigationStack {
            ZStack {
                if let weather = weather {
                    BackgroundView(isDay: isDay)
                    ScrollView {
                        VStack {
                            SearchBar(
                                searchText: $searchText,
                                isConditionMet: isDay,
                                onLocationButtonTap: handleLocationButtonTap
                            )

                            TopSection(weather: weather)
                            Spacer()
                            MiddleSection(weather: weather)
                            Spacer().frame(height: 20)
                            BottomSection(weather: weather)
                        }
                    }
                    .onAppear {
                        locationManager.locationUpdateCompletion = { location in
                            let coordinates = "\(location.coordinate.latitude),\(location.coordinate.longitude)"
                            searchText = coordinates
                            loadData()
                            searchText = ""
                        }
                    }
                } else {
                    Image(.loading)
                        .resizable()
                        .frame(width: 300, height: 300)
                        .onAppear(perform: {loadData()})
                }
            }
            .foregroundColor(isDay ? .black : .white)
            .onSubmit {
                loadData()
                searchText = ""
            }

        }
    }

    private func handleLocationButtonTap() {
           locationManager.requestWhenInUseAuthorization()
       }

    private func loadData(location: String = "30.0715495,31.0215953") {
        let locationQuery = searchText.isEmpty ? location : searchText
        WeatherService.fetchWeather(for: locationQuery) { fetchedWeather in
            DispatchQueue.main.async {
                if let weatherData = fetchedWeather {
                    weather = weatherData
                    isDay = weatherData.current.isDay == 1
                } else {
                    print(locationQuery)
                    print("Failed to fetch weather data")
                }
            }
        }
    }

}


struct MainScreenView_Previews: PreviewProvider {
    static var previews: some View {
        MainScreenView(isDay: true)
    }
}
