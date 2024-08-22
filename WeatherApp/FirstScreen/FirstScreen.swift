//
//  ContentView.swift
//  WeatherApp
//
//  Created by Engy on 8/22/24.
//

import SwiftUI

struct FirstScreen: View {
    @State var weather: Weather?
    @State var isDay: String?

    var body: some View {
        if let weather = weather {
            ZStack {
                BackgroundView(isDay: (weather.current.isDay == 1))

                ScrollView {
                    VStack {
                        TopSection(weather: weather)
                        Spacer()
                        MiddleSection(weather: weather)
                        Spacer().frame(height: 20)
                        BottomSection(weather: weather)
                    }

                }
            }
        } else {
            Text("loading ...")
                .onAppear {
                    loadData()
                }
        }

    }



}
extension FirstScreen {
    private func loadData() {
        WeatherService.fetchWeather(completion: { fetchedWeather in
            if let weatherData = fetchedWeather {
                DispatchQueue.main.async {
                    weather = weatherData

                }
            }

        })
    }

}




#Preview {
    FirstScreen()
}
