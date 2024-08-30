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
    var onLocationButtonTap: () -> Void

    var body: some View {
        HStack {
            HStack{
                Image(systemName: "magnifyingglass")
                    .padding(.leading, 8)
                    .font(.system(size: 20))
                TextField("", text: $searchText,prompt:
                            Text("Search").foregroundStyle(.gray))
                .textFieldStyle(PlainTextFieldStyle())
                .padding(10)

                Button(action: onLocationButtonTap) {

                               Image(systemName: "location.fill")
                                   .padding(8)
                           }
                .font(.system(size: 20))

            }
            .background(.ultraThinMaterial)
            .cornerRadius(10)

            if !searchText.isEmpty {
                Button(action: {
                    searchText = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 20))
                        .padding(.trailing, 8)
                }
            }

        }

        .foregroundColor(isConditionMet ? .black : .white)
        .padding(10)
        .frame(width: UIScreen.main.bounds.width-20,height: 40)
    }
}


