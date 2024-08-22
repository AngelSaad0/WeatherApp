//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Engy on 8/22/24.
//
//https://api.weatherapi.com/v1/forecast.json?key=cde657024d7d4f2c967131756242208&q=30.0715495,31.0215953&days=3&aqi=yes&alerts=no
import Foundation
class WeatherService {

     static func fetchWeather(completion:@escaping((Weather)?)->Void) {
        let apiKey = "cde657024d7d4f2c967131756242208"
        let urlString = "https://api.weatherapi.com/v1/forecast.json?key=\(apiKey)&q=30.0715495,31.0215953&days=3&aqi=yes&alerts=no"
        guard let url = URL(string: urlString) else{
            completion(nil)
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error  in
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
                let users = try JSONDecoder().decode(Weather.self, from: data)
                completion(users)
            } catch {
                print("Error decoding data: \(error.localizedDescription)")
                completion(nil)
            }
        }

        task.resume()
    }


}
