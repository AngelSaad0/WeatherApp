//
//  MiddleSection.swift
//  WeatherApp
//
//  Created by Engy on 8/22/24.
//


import SwiftUI

struct MiddleSection: View {
    var weather: WeatherData

    private var iconURL: String { "https:\(weather.current.condition.icon)" }

    var body: some View {
        VStack {
            WeatherImageView(url: iconURL, width: 100, height: 100, padding: -20).scaledToFill()
            Spacer()
            Text("3-DAY FORECAST")
                .font(.headline)
            DecorativeRectangleView(padding: 20)

            let forecastDays = weather.forecast.forecastday
            ForEach(forecastDays, id: \.date) { item in
                let dataName = WeatherTimeFormatter.dayOfWeek(from: item.date)
                NavigationLink {
                    DetailsScreenView(hours: item.hour, isDay: (weather.current.isDay != 0), title:dataName.0)
                } label: {
                    HStack {
                        Text(dataName.1)
                            .frame(width: UIScreen.main.bounds.width * 0.28, alignment: .leading)
                        WeatherImageView(url: iconURL, padding: -20)
                        Text("\(item.day.mintempC, specifier: "%.1f")° - \(item.day.maxtempC, specifier: "%.1f")°")

                            .frame(width: UIScreen.main.bounds.width * 0.28, alignment: .trailing)
                            .font(.system(size: 17))
                    }
                    .font(.title2)
                }
                DecorativeRectangleView(padding: 60, height: 0.4)
                    .padding(.horizontal)
            }
        }
        .frame(width: UIScreen.main.bounds.width, alignment: .center)
    }

    private func dayName(from dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: dateString) else { return dateString }

        let todayDateString = dateFormatter.string(from: Date())
        if dateString == todayDateString {
            return "Today"
        } else {
            let dayFormatter = DateFormatter()
            dayFormatter.dateFormat = "EEEE"
            return dayFormatter.string(from: date)
        }
    }
}

#Preview {
    MainScreenView(isDay: true)
}
