//
//  ContentView.swift
//  WeatherApp
//
//  Created by Engy on 8/22/24.
//
import SwiftUI

struct WeatherMainView: View {
    @StateObject private var viewModel = WeatherViewModel()
    @State private var animateView = false

    var body: some View {
        NavigationStack {
            ZStack {
                if let weather = viewModel.weather {
                    BackgroundView(isDay: viewModel.isDay)

                    ScrollView {
                        VStack {
                            searchSection
                            weatherSummarySection(for: weather)
                            forecastSection(for: weather)
                            additionalInfoSection(for: weather)


                        }
                        //.frame(height: UIScreen.main.bounds.height*0.9)
                        .onAppear(perform: animateViewOnAppear)
                    }
                    .animation(.easeInOut(duration: 1.0), value: viewModel.isDay)
                    .foregroundColor(viewModel.isDay ? .black : .white)
                    .onSubmit { viewModel.fetchData() }
                } else {
                    loadingView
                }
            }
        }
    }

    private var searchSection: some View {
        SearchBar(
            searchText: $viewModel.searchText,
            isConditionMet: viewModel.isDay,
            onLocationButtonTap: viewModel.requestLocationAuthorization
        )
    }

    private func weatherSummarySection(for weather: WeatherData) -> some View {
        VStack {
            Text(weather.location.name)
                .font(.largeTitle)
            Text("  \(Int(weather.current.tempC))°")
                .font(.system(size: 72))
            Text(weather.current.condition.text)
            Text("H:\(Int(weather.forecast.forecastday[0].day.maxtempC))° L:\(Int(weather.forecast.forecastday[0].day.mintempC))°")
            WeatherImageView(url: "https:\(weather.current.condition.icon)", width: 100, height: 100, padding: -20)
                .scaleEffect(0.7)
        }
        .animation(.easeInOut(duration: 0.5), value: viewModel.isDay)
        .opacity(animateView ? 1 : 0)
    }

    private func forecastSection(for weather: WeatherData) -> some View {
        VStack {
            Text("3-DAY FORECAST")
                .font(.headline)
            DecorativeRectangleView(padding: 20)

            ForEach(weather.forecast.forecastday, id: \.date) { item in
                forecastRow(for: item)
                DecorativeRectangleView(padding: 60, height: 0.4)
                    .padding(.horizontal)
            }
        }
        .frame(width: UIScreen.main.bounds.width, alignment: .center)
        .padding(.vertical,30)
    }

    private func forecastRow(for item: Forecastday) -> some View {
        let dataName = WeatherTimeFormatter.dayOfWeek(from: item.date, timeZone: viewModel.weather?.location.localtime ?? "")
        return NavigationLink {
            DetailsScreenView(
                hours: item.hour,
                isDay: viewModel.isDay,
                title: dataName.1,
                timeZone: viewModel.weather?.location.localtime ?? ""
            )
        } label: {
            HStack {
                Text(dataName.1)
                    .frame(width: UIScreen.main.bounds.width * 0.28, alignment: .leading)
                WeatherImageView(
                    url: "https:\(item.day.condition.icon)",
                    width: 40,
                    height: 40,
                    padding: -20
                )
                .scaledToFill()
                Text("\(item.day.mintempC, specifier: "%.1f")° - \(item.day.maxtempC, specifier: "%.1f")°")
                    .frame(width: UIScreen.main.bounds.width * 0.28, alignment: .trailing)
                    .font(.system(size: 17))
            }
            .font(.title2)
        }
    }

    private func additionalInfoSection(for weather: WeatherData) -> some View {
        VStack {
            HStack {
                InfoBlock(title: "Visibility", value: "\(Int(weather.current.visKM)) km")
                InfoBlock(title: "Humidity", value: "\(weather.current.humidity)%")
            }
            .padding(.bottom)

            HStack {
                InfoBlock(title: "Feels Like", value: "\(Int(weather.current.feelslikeC))°")
                InfoBlock(title: "Pressure", value: "\(weather.current.pressureMB)")
            }
        }
        .frame(width: UIScreen.main.bounds.width)
    }

    private var loadingView: some View {
        Image(.loading)
            .resizable()
            .frame(width: 300, height: 300)
            .onAppear { viewModel.fetchData() }
    }

    private func animateViewOnAppear() {
        withAnimation(.easeInOut(duration: 2.0)) {
            animateView = true
        }
    }
}


#Preview {
    WeatherMainView()
}
