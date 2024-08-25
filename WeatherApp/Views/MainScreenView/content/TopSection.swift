//
//  topSection.swift
//  WeatherApp
//
//  Created by Engy on 8/22/24.
//

import SwiftUI

struct TopSection: View {
    var weather: WeatherData

    private var locationName: String { weather.location.name }
    private var temperature: String { "\(Int(weather.current.tempC))°" }
    private var conditionText: String { weather.current.condition.text }
    private var highLowTemperature: String {
        let maxTemp = Int(weather.forecast.forecastday[0].day.maxtempC)
        let minTemp = Int(weather.forecast.forecastday[0].day.mintempC)
        return "H:\(maxTemp)° L:\(minTemp)°"
    }

    var body: some View {
        VStack {
            Text(locationName)
                .font(.largeTitle)
            Text(temperature)
                .font(.system(size: 72))
            Text(conditionText)
            Text(highLowTemperature)
        }
    }
}

#Preview {
    MainScreenView()
}
