//
//  DetailsScreenView.swift
//  WeatherApp
//
//  Created by Engy on 8/22/24.
//

import SwiftUI

struct DetailsScreenView: View {
    @StateObject private var viewModel: DetailsViewModel
    let isDay: Bool
    let title: String
    @Environment(\.presentationMode) private var presentationMode

    init(hours: [Current], isDay: Bool, title: String, timeZone: String) {
        _viewModel = StateObject(wrappedValue: DetailsViewModel(hours: hours, timeZone: timeZone))
        self.isDay = isDay
        self.title = title
    }

    var body: some View {
        ZStack {
            BackgroundView(isDay: isDay)

            ScrollView {
                VStack(spacing: 10) {
                    ForEach(viewModel.filteredHours, id: \.time) { hour in
                        HStack {
                            Text(viewModel.timeOrCurrentHour(from: hour.time ?? ""))
                                .frame(width: UIScreen.main.bounds.width * 0.25, alignment: .leading)
                            WeatherImageView(url: "https:\(hour.condition.icon)", width: 90, height: 60, padding: -20)
                            Text("\(Int(hour.tempC))°")
                                .frame(width: UIScreen.main.bounds.width * 0.25, alignment: .trailing)
                        }
                        .padding(.horizontal)
                    }
                }
                .frame(width: UIScreen.main.bounds.width)
            }
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

//#Preview {
//   
//}
