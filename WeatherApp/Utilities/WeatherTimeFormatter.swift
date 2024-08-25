//
//  TimeFormatter.swift
//  WeatherApp
//
//  Created by Engy on 8/25/24.
//

import Foundation

struct WeatherTimeFormatter {

    static func filteredHours(from hours: [Current]) -> [Current] {
        let currentTime = Date()
        let oneHourBefore = Calendar.current.date(byAdding: .hour, value: -1, to: currentTime)!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"

        return hours.compactMap { hour in
            if let timeString = hour.time, let date = dateFormatter.date(from: timeString) {
                return date >= oneHourBefore ? hour : nil
            }
            return nil
        }
    }

    static func timeOrCurrentHour(from dateString: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        guard let date = dateFormatter.date(from: dateString) else { return nil }
        let calendar = Calendar.current
        let currentDate = Date()

        let currentHour = calendar.component(.hour, from: currentDate)
        let currentDay = calendar.component(.day, from: currentDate)
        let givenHour = calendar.component(.hour, from: date)
        let givenDay = calendar.component(.day, from: date)

        if currentDay == givenDay && givenHour == currentHour {
            return "Now"
        } else if !(currentDay == givenDay && givenHour < currentHour) {
            dateFormatter.dateFormat = "h a"
            return dateFormatter.string(from: date)
        }

        return nil
    }
    static func dayOfWeek(from dateString: String) -> (String, String) {
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "yyyy-MM-dd"
           guard let date = dateFormatter.date(from: dateString) else { return ("", "") }

           let calendar = Calendar.current
           let today = calendar.isDateInToday(date)

           if today {
               return ("Today", "Today")
           } else {
               dateFormatter.dateFormat = "EEEE"
               let fullDayName = dateFormatter.string(from: date)
               return (fullDayName, String(fullDayName.prefix(3)))
           }
       }
}

