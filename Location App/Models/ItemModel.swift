//
//  ItemModel.swift
//  Location App
//
//  Created by yatziri on 05/12/23.
//

import Foundation
import SwiftData
import MapKit

@Model
class Alarms{
    var snooze: Bool
    var activated: Bool
    var name: String
    var sound: String
    var weather: WeatherData?
    var isWeatherAlarm: Int
    //0 = weather
    //1 = location
//    var fk_weather: Weather?
    var locationStart: Location?
    var locationFinish: Location?


    init(snooze: Bool, name: String, activated: Bool,sound: String, isWeatherAlarm: Int, weather: WeatherData?, locationStart: Location? = nil, locationFinish: Location? = nil) {
        self.snooze = snooze
        self.activated = activated
        self.name = name
        self.weather = weather
        self.sound = sound
        self.isWeatherAlarm = isWeatherAlarm
//        self.fk_weather = fk_weather
        self.locationStart = locationStart
        self.locationFinish = locationFinish
    }
}

@Model
class Weather{
    var type: String
    var temperature: Int
    var alarmS_weather: [Alarms]?

    init(type: String, temperature: Int, alarmS_weather: [Alarms]? = nil) {
        self.type = type
        self.temperature = temperature
        self.alarmS_weather = alarmS_weather
    }
}


@Model
class Location{
    var name: String
    var location1:  Coordinate2D
//    var alarmS_weather: [Alarms]?
    var alarmS_locationStart: [Alarms]?
    var alarmS_locationFinish: [Alarms]?


    init(name: String, location1:   Coordinate2D, alarmS_locationStart: [Alarms]? = nil, alarmS_locationFinish: [Alarms]? = nil) {
        self.name = name
        self.location1 = location1
//        self.alarmS_weather = alarmS_weather
        self.alarmS_locationStart = alarmS_locationStart
        self.alarmS_locationFinish = alarmS_locationFinish
    }
}


struct Coordinate2D: Codable {
    let latitude: Double
    let longitude: Double

    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}

extension Coordinate2D {
    init(_ location1: CLLocationCoordinate2D) {
        self.latitude = location1.latitude
        self.longitude = location1.longitude
    }

    var location1: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

