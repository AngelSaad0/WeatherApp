//
//  DetailsViewModel.swift
//  WeatherApp
//
//  Created by Engy on 8/29/24.
//

import SwiftUI
import Combine

class DetailsViewModel: ObservableObject {
    @Published var filteredHours: [Current] = []

    private let hours: [Current]
    private let timeZone: String

    init(hours: [Current], timeZone: String) {
        self.hours = hours
        self.timeZone = timeZone
        self.filteredHours = WeatherTimeFormatter.filteredHours(from: hours, timeZone: timeZone)
    }

    func timeOrCurrentHour(from time: String) -> String {
        WeatherTimeFormatter.timeOrCurrentHour(from: time, timeZone: timeZone) ?? ""
    }
}
