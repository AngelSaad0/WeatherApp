//
//  DetailsScreenView.swift
//  WeatherApp
//
//  Created by Engy on 8/22/24.
//

import SwiftUI

import SwiftUI

struct DetailsScreenView: View {
    let hours: [Current]
    let isDay: Bool
    let title: String
    @Environment(\.presentationMode) private var presentationMode

    var body: some View {
        ZStack {
            BackgroundView(isDay: isDay)

            ScrollView {
                VStack(spacing: 10) {
            
                    ForEach(WeatherTimeFormatter.filteredHours(from: hours), id: \.time) { hour in
                        HourlyForecastRow(
                            time: (hour.time ?? ""),
                            iconURL: "https:\(hour.condition.icon)",
                            temperature: "\(Int(hour.tempC))°"
                        )
                        .padding(.horizontal)
                    }
                }
                .frame(width: UIScreen.main.bounds.width)
            }
            .navigationBarBackButtonHidden(true)
            .navigationTitle(title)
            .font(.largeTitle)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(title)
                        .font(.largeTitle)
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { presentationMode.wrappedValue.dismiss() }) {
                        Image(systemName: "arrow.left.circle")
                            .font(.title3)
                    }
                }
            }
            .foregroundColor(isDay ? .black : .white)
        }
    }
}

