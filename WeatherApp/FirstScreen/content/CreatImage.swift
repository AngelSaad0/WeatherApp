//
//  CreatImage.swift
//  WeatherApp
//
//  Created by Engy on 8/22/24.
//

import SwiftUI
struct CreatImage:View {
    let url:String
    var width:CGFloat = 50
    var height:CGFloat = 50
    var pading:CGFloat = 0
    var body: some View {
            AsyncImage(url: URL(string: url)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .scaledToFit()
                        .frame(width: width, height: height)
                        .clipShape(Circle())
                        .padding(.vertical,pading)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: width, height: height)
                        .clipShape(Circle())
                        .padding(.vertical,pading)

                case .failure:
                    Image(systemName: "photo")
                        .resizable()
                        .frame(width: width, height: height)
                        .clipShape(Circle())
                        .padding(.vertical,pading)

                @unknown default:
                    EmptyView()
                }
            }
        }

}
