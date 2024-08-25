//
//  SearchBar.swift
//  WeatherApp
//
//  Created by Engy on 8/25/24.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String
    var isConditionMet: Bool

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
                .padding(.leading, 8)
            TextField("Search", text: $searchText)
                .textFieldStyle(PlainTextFieldStyle())
                .padding(10)
                .foregroundColor(isConditionMet ? .black : .white)
                .background(.ultraThinMaterial)
                .cornerRadius(10)

            if !searchText.isEmpty {
                Button(action: {
                    searchText = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.yellow)
                        .padding(.trailing, 8)
                }
            }
        }
        .padding(10)
        .frame(width: UIScreen.main.bounds.width-20)
    }
}


