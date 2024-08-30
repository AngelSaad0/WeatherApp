////
////  HourlyForecastRow.swift
////  WeatherApp
////
////  Created by Engy on 8/25/24.
////
//
//import SwiftUI
//
//struct HourlyForecastRow: View {
//    let time: String
//    let iconURL: String
//    let temperature: String
//    let timeZone: String
//    let iconWidth: CGFloat
//    let iconHeight: CGFloat
//
//    var body: some View {
//        HStack {
//            Text(WeatherTimeFormatter.timeOrCurrentHour(from: time, timeZone: timeZone) ?? "")
//                .frame(width: UIScreen.main.bounds.width * 0.25, alignment: .leading)
//            WeatherImageView(url: iconURL, width: iconWidth, height: iconHeight, padding: -20)
//            Text(temperature)
//                .frame(width: UIScreen.main.bounds.width * 0.25, alignment: .trailing)
//        }
//    }
//}
