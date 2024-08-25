//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Engy on 8/22/24.
//
//https://api.weatherapi.com/v1/forecast.json?key=cde657024d7d4f2c967131756242208&q=30.0715495,31.0215953&days=3&aqi=yes&alerts=no
//let urlString = "https://api.weatherapi.com/v1/forecast.json?key=\(apiKey)&q=30.0715495,31.0215953&days=3&aqi=yes&alerts=no"
//https://api.weatherapi.com/v1/forecast.json?key=cde657024d7d4f2c967131756242208&q=30.0715495,31.0215953&days=3&aqi=yes&alerts=no

import Foundation

class WeatherService {

    private static let apiKey = "cde657024d7d4f2c967131756242208"
    private static let baseURL = "https://api.weatherapi.com/v1/forecast.json"
    private static let defaultLocation = "30.0715495,31.0215953"




    static func fetchWeather(for location: String?, completion: @escaping (WeatherData?) -> Void) {
        guard let url = buildURL(for: location) else {
            print("Invalid URL.")
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            handleResponse(data: data, error: error, completion: completion)
        }.resume()
    }




    private static func buildURL(for location: String?) -> URL? {
        let locationQuery = location?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? defaultLocation
        let urlString = "\(baseURL)?key=\(apiKey)&q=\(locationQuery)&days=3&aqi=yes&alerts=no"
        return URL(string: urlString)
    }

    private static func handleResponse(data: Data?, error: Error?, completion: @escaping (WeatherData?) -> Void) {
        if let error = error {
            print("Request error: \(error.localizedDescription)")
            completion(nil)
            return
        }

        guard let data = data else {
            print("No data returned from the server.")
            completion(nil)
            return
        }

        do {
            let weatherData = try JSONDecoder().decode(WeatherData.self, from: data)
            completion(weatherData)
        } catch {
            print("Error decoding data: \(error.localizedDescription)")
            completion(nil)
        }
    }
}
