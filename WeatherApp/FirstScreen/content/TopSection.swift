//
//  topSection.swift
//  WeatherApp
//
//  Created by Engy on 8/22/24.
//

    import SwiftUI
    struct TopSection:View {
        var weather:Weather
        var body: some View {
            ZStack {
                VStack {
                        Text(weather.location.name)
                            .font(.largeTitle)
                        Text("\(Int(weather.current.tempC))°")
                            .font(.system(size: 72))
                        Text(weather.current.condition.text.rawValue)
                        Text("H:\(Int(weather.forecast.forecastday[0].day.maxtempC))° L:\(Int(weather.forecast.forecastday[0].day.mintempC))°")
                }
                .foregroundColor(weather.current.isDay==1 ? .black:.white)
            }

        }
    }
    #Preview {
        FirstScreen()
    }

