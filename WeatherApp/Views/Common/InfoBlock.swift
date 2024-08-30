//
//  InfoBlock.swift
//  WeatherApp
//
//  Created by Engy on 8/29/24.
//

import SwiftUI
struct InfoBlock: View {
    var title: String
    var value: String

    var body: some View {
        VStack {
            Text(title)
                .font(.caption)
            Text(value)
                .font(.largeTitle)
                .fontWeight(.medium)
        }
        .frame(maxWidth: .infinity)
    }
}

