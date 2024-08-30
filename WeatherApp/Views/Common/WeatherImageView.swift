//
//  CreatImage.swift
//  WeatherApp
//
//  Created by Engy on 8/22/24.
//

import SwiftUI

struct WeatherImageView: View {
    let url: String
    var width: CGFloat
    var height: CGFloat 
    var padding: CGFloat = 0

    var body: some View {
        AsyncImage(url: URL(string: url)) { phase in
            switch phase {
            case .empty:
                ProgressView()
                    .scaledToFit()
                    .frame(width: width, height: height)
                    .clipShape(Circle())
                    .padding(.vertical, padding)
            case .success(let image):
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: width, height: height)
                    .clipShape(Circle())
                    .padding(.vertical, padding)
            case .failure:
                Image(systemName: "photo")
                    .resizable()
                    .frame(width: width, height: height)
                    .clipShape(Circle())
                    .padding(.vertical, padding)
            @unknown default:
                EmptyView()
            }
        }
    }
}


