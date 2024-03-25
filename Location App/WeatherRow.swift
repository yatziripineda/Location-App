//
//  WeatherView.swift
//  Location App
//
//  Created by yatziri on 18/03/24.
//
//
import SwiftUI
//
struct WeatherRow: View {
    var weather: WeatherData
    var isSelected = false
    var body: some View {
        HStack {
            VStack(alignment: .leading){
                Text("Condition: ")
                    .font(.footnote)
                    .foregroundColor(.gray  )
                Text("\(weather.condition)")
                    .font(.title3)
                    .bold()
                
            }
            Spacer()
            VStack{
                Spacer()
                Text("\(weather.temperature)°C")
                    .bold()
//                    .padding()
//                    .font(.title2)
            }
        }
        .padding()
        .background(isSelected ? Color.blue.opacity(0.1) : Color.clear)
        .cornerRadius(5)
    }
}


