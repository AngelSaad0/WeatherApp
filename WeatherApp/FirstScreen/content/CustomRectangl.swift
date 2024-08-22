//
//  CustomRectangl.swift
//  WeatherApp
//
//  Created by Engy on 8/22/24.
//

import SwiftUI
struct CustomRectangl:View{
    var padding: CGFloat = 10
    var height: CGFloat = 0.6

        var body: some View {
            Rectangle()
                .frame(width: UIScreen.main.bounds.width - padding, height: height)
                .background(Color.gray)
        }
    }



