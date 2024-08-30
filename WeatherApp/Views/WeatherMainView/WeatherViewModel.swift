//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Engy on 8/29/24.
//

import Foundation
import Combine

class WeatherViewModel: ObservableObject {
    @Published var weather: WeatherData?
    @Published var isDay: Bool = true
    @Published var searchText: String = ""

    private var cancellables = Set<AnyCancellable>()
    private let locationManager = LocationManager()

    init() {
        setupLocationManager()
        fetchData()
    }

    func fetchData() {
        let locationQuery = searchText.isEmpty ? "30.0715495,31.0215953" : searchText
        WeatherService.fetchWeather(for: locationQuery) { [weak self] fetchedWeather in
            DispatchQueue.main.async {
                if let weatherData = fetchedWeather {
                    self?.weather = weatherData
                    self?.isDay = weatherData.current.isDay == 1
                } else {
                    print("Failed to fetch weather data for \(locationQuery)")
                }
            }
        }
        self.searchText = ""

    }

    private func setupLocationManager() {
        locationManager.locationUpdateCompletion = { [weak self] location in
            let coordinates = "\(location.coordinate.latitude),\(location.coordinate.longitude)"
            self?.searchText = coordinates
            self?.fetchData()
            self?.searchText = ""
        }
    }

    func requestLocationAuthorization() {
        locationManager.requestWhenInUseAuthorization()
    }
}
