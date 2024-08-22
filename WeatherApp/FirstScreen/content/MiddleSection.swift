//
//  MiddleSection.swift
//  WeatherApp
//
//  Created by Engy on 8/22/24.
//


import SwiftUI
struct MiddleSection:View {
    var weather:Weather

    var body: some View {
        VStack {
            
            let UrlString = String(describing: "https:\(weather.current.condition.icon.rawValue)")
            CreatImage(url:UrlString,width:150,height:150,pading: -45).scaledToFill()
            Spacer()
            Text("3-DAY FORECAST")
                .font(.headline)
            CustomRectangl(padding: 20)
            let forecastDays = weather.forecast.forecastday

            ForEach(forecastDays, id: \.date) { item in
                let dataName = dayName(from: item.date)
                NavigationLink {
                    SecondScreen(hours: item.hour, isDay: weather.current.isDay, title: dataName)
                } label: {
                    HStack {
                        Text(dataName)
                            .frame(width: UIScreen.main.bounds.width*0.28,alignment: .leading)
                        CreatImage(url: UrlString,pading: -20)

                        Text("\(Int(item.day.mintempC))° - \(Int(item.day.maxtempC))°")
                            .frame(width: UIScreen.main.bounds.width*0.28,alignment: .trailing)

                    }
                    .font(.title2)
                }
                CustomRectangl(padding: 60,height: 0.4)
                    .padding(.horizontal)


            }
        }
        .foregroundColor(weather.current.isDay==1 ? .black:.white)
        .frame(width: UIScreen.main.bounds.width,alignment: .center)


    }
    private func dayName(from dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: dateString) else {
                return dateString
            }
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
    FirstScreen()
}

