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
                            SearchBar(searchText: $searchText, isConditionMet: isDay, onLocationButtonTap: {
                                if let location = locationManager.currentLocation {
                                    let coordinates = "\(location.coordinate.latitude),\(location.coordinate.longitude)"
                                    searchText = coordinates
                                    loadData()
                                    searchText = ""

                                }
                            })

                            TopSection(weather: weather)
                            Spacer()
                            MiddleSection(weather: weather)
                            Spacer().frame(height: 20)
                            BottomSection(weather: weather)
                        }
                    }
                } else {
                    Image(.loading)
                        .resizable()
                        .frame(width: 300,height: 300)
                        .onAppear(perform: {loadData()})
                 }
            }


            .foregroundColor(isDay ? .black : .white)
            .onSubmit {
                loadData()
                searchText = ""
            }
            .onChange(of: locationManager.authorizationStatus) { status in
                if status == .denied || status == .restricted {
                    showSettingsAlert = true
                }
            }
            .alert(isPresented: $showSettingsAlert) {
                Alert(
                    title: Text("Location Services Disabled"),
                    message: Text("Please enable location services in the settings to use this feature."),
                    primaryButton: .default(Text("Open Settings"), action: {
                        openAppSettings()
                    }),
                    secondaryButton: .cancel()
                )
            }
        }
    }

    private func loadData(location:String = "30.0715495,31.0215953" ) {
        let location = searchText.isEmpty ? "30.0715495,31.0215953": searchText
        WeatherService.fetchWeather(for: location) { fetchedWeather in
            DispatchQueue.main.async {
                if let weatherData = fetchedWeather {
                    weather = weatherData
                    isDay = weatherData.current.isDay == 1
                } else {
                    print(location)
                    print("Failed to fetch weather data")
                }
            }
        }
    }

    private func openAppSettings() {
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
            print("Invalid settings URL")
            return
        }
        if UIApplication.shared.canOpenURL(settingsUrl) {
            UIApplication.shared.open(settingsUrl, options: [:]) { success in
                if success {
                    print("Successfully opened app settings")
                } else {
                    print("Failed to open app settings")
                }
            }
        } else {
            print("Cannot open URL: \(settingsUrl)")
        }
    }
}




struct MainScreenView_Previews: PreviewProvider {
    static var previews: some View {
        MainScreenView(isDay: true)
    }
}
