//
//  TimeFormatter.swift
//  WeatherApp
//
//  Created by Engy on 8/25/24.
//

import Foundation

import Foundation

struct WeatherTimeFormatter {

    static func filteredHours(from hours: [Current], timeZone: String) -> [Current] {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        let currentDate = dateFormatter.date(from: timeZone) ?? Date.now

        let calendar = Calendar.current

        let oneHourBefore = calendar.date(byAdding: .hour, value: -1, to: currentDate)!



        return hours.filter { hour in
            guard let timeString = hour.time, let date = dateFormatter.date(from: timeString) else {
                return false
            }
            return date >= oneHourBefore
        }
    }




    static func timeOrCurrentHour(from dateString: String, timeZone: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        let currentDate = dateFormatter.date(from: timeZone) ?? Date.now

        let calendar = Calendar.current

        guard let date = dateFormatter.date(from: dateString) else { return nil }

        if calendar.isDate(date, equalTo: currentDate, toGranularity: .hour) {
            return "Now"
        } else {
            dateFormatter.dateFormat = "ha"
            return dateFormatter.string(from: date)
        }
    }

    static func dayOfWeek(from dateString: String, timeZone: String) -> (String, String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "yyyy-MM-dd HH:mm"

        guard let date = dateFormatter.date(from: dateString) else { return ("", "") }
        guard let currentDate = dateFormatter2.date(from: timeZone) else {
            return ("", "") }

        if Calendar.current.dateComponents([.day], from: date) == Calendar.current.dateComponents([.day], from: currentDate) {
            return ("Today", "Today")
        } else {
            dateFormatter.dateFormat = "EEEE"
            let fullDayName = dateFormatter.string(from: date)
            let shortDayName = String(fullDayName.prefix(3))
            return (fullDayName, shortDayName)
        }
    }
}
