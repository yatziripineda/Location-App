//
//  WeatherSruct.swift
//  Location App
//
//  Created by yatziri on 21/03/24.
//

import Foundation

struct WeatherData: Hashable, Codable {
    var temperature: Int
    var condition: String
}




//class WeatherDataViewModel: ObservableObject {
//    @Published var weathers: [WeatherData] = [
//        WeatherData(temperature: 25, condition: "Sunny"),
//        WeatherData(temperature: 15, condition: "Cloudy"),
//        WeatherData(temperature: 20, condition: "Partly Cloudy")
//    ]
//}
