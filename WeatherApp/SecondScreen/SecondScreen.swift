//
//  SecondScreen.swift
//  WeatherApp
//
//  Created by Engy on 8/22/24.
//

import SwiftUI

struct SecondScreen: View {
    let hours:[Current]
    let isDay:Int
    let title:String
    @Environment(\.presentationMode) private var presentationMode

    var body: some View {
        ZStack {

            BackgroundView(isDay: isDay == 1)

            ScrollView{

                Spacer().frame(height: 50)


                VStack {
                    ForEach(hours,id:\.time) { hour in
                        let UrlString = String(describing: "https:\(hour.condition.icon.rawValue)")

                        HStack {
                            Text(formatTime(hour.time ?? ""))
                                .frame(width: UIScreen.main.bounds.width*0.25,alignment: .leading)
                            CreatImage(url: UrlString,pading: -20)

                            Text("\(Int(hour.tempC))°")
                                .frame(width: UIScreen.main.bounds.width*0.25,alignment: .trailing)


                        }

                    }
                    .padding(.horizontal)

                }
                .frame(width: UIScreen.main.bounds.width)

            }      .navigationBarBackButtonHidden(true)

            .navigationTitle(title).font(.largeTitle)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text(title)
                            .font(.largeTitle)
                            .foregroundColor(isDay == 1 ? .black : .white) 
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            HStack(spacing: 4) {
                                Image(systemName: "arrow.left.circle")
                                    .font(.title3)

                            }
                            .foregroundColor(isDay == 1 ? .black : .white)
                        }



                    }



                } .foregroundColor(isDay == 1 ? .black : .white)
                .font(.title)

        }
    }
}
        private func formatTime(_ dateString: String) -> String {
            let inputFormatter = DateFormatter()
            inputFormatter.dateFormat = "yyyy-MM-dd HH:mm"
            guard let date = inputFormatter.date(from: dateString) else {
                return dateString
            }

            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "h a"
            return outputFormatter.string(from: date)
        }


    #Preview {
        FirstScreen()
    }
