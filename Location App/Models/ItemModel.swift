//
//  ItemModel.swift
//  Location App
//
//  Created by yatziri on 05/12/23.
//

import Foundation
import SwiftData

@Model
class Alarms: Codable {
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

    enum CodingKeys: String, CodingKey {
        case snooze
        case activated
        case name
        case sound
        case weather
//        case fk_weather
        case locationStart
        case locationFinish
        case isWeatherAlarm
    }

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

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.snooze = try container.decode(Bool.self, forKey: .snooze)
        self.activated = try container.decode(Bool.self, forKey: .activated)
        self.name = try container.decode(String.self, forKey: .name)
        self.sound = try container.decode(String.self, forKey: .sound)
        self.isWeatherAlarm = try container.decode(Int.self, forKey: .isWeatherAlarm)
        self.weather = try container.decode(WeatherData.self, forKey: .weather)
        self.locationStart = try container.decodeIfPresent(Location.self, forKey: .locationStart)
        self.locationFinish = try container.decodeIfPresent(Location.self, forKey: .locationFinish)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(snooze, forKey: .snooze)
        try container.encode(activated, forKey: .activated)
        try container.encode(name, forKey: .name)
        try container.encode(sound, forKey: .sound)
        try container.encode(isWeatherAlarm, forKey: .isWeatherAlarm)
//        try container.encode(fk_weather, forKey: .fk_weather)
        try container.encode(locationStart, forKey: .locationStart)
        try container.encode(locationFinish, forKey: .locationFinish)
    }
}

@Model
class Weather: Codable {
    var type: String
    var temperature: Int
    var alarmS_weather: [Alarms]?

    enum CodingKeys: String, CodingKey {
        case type
        case temperature
    }

    init(type: String, temperature: Int, alarmS_weather: [Alarms]? = nil) {
        self.type = type
        self.temperature = temperature
        self.alarmS_weather = alarmS_weather
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.type = try container.decode(String.self, forKey: .type)
        self.temperature = try container.decode(Int.self, forKey: .temperature)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(type, forKey: .type)
        try container.encode(temperature, forKey: .temperature)
    }
}

@Model
class Location: Codable {
    @Attribute(.unique)
    var postCode: Int
    var street: String
    var num: Int
    var alarmS_weather: [Alarms]?
    var alarmS_locationStart: [Alarms]?
    var alarmS_locationFinish: [Alarms]?

    enum CodingKeys: String, CodingKey {
        case postCode
        case street
        case num
    }

    init(postCode: Int, street: String, num: Int, alarmS_weather: [Alarms]? = nil, alarmS_locationStart: [Alarms]? = nil, alarmS_locationFinish: [Alarms]? = nil) {
        self.postCode = postCode
        self.street = street
        self.num = num
        self.alarmS_weather = alarmS_weather
        self.alarmS_locationStart = alarmS_locationStart
        self.alarmS_locationFinish = alarmS_locationFinish
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.street = try container.decode(String.self, forKey: .street)
        self.postCode = try container.decode(Int.self, forKey: .postCode)
        self.num = try container.decode(Int.self, forKey: .num)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(street, forKey: .street)
        try container.encode(postCode, forKey: .postCode)
        try container.encode(num, forKey: .num)
    }
}


//
//@Model
//final class Alarm_Weather :Codable {
//    
//    
//    var snooze: Bool
//    var name: String
//    var sound: String
//    @Relationship(deleteRule: .nullify, inverse: \Weather.alarmS_weather)
//    var fk_weather: Weather?
//   
//    
//    enum CodingKeys: String, CodingKey {
//        case snooze
//        case name
//        case sound
//        case fk_weather
//        
//    }
//    init(snooze: Bool, name: String, sound: String, fk_weather: Weather? = nil) {
//        self.snooze = snooze
//        self.name = name
//        self.sound = sound
//        self.fk_weather = fk_weather
//    }
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.snooze = try container.decode(Bool.self, forKey: .snooze)
//        self.name = try container.decode(String.self, forKey: .name)
//        self.sound = try container.decode(String.self, forKey: .sound)
//        self.fk_weather = try container.decodeIfPresent(Weather.self, forKey: .fk_weather)
////        self.category = try container.decodeIfPresent(Category.self, forKey: .category)
////
////        if let imageName = try container.decodeIfPresent(String.self, forKey: .imageName),
////           let imageData = UIImage(named: imageName) {
////            self.image = imageData.jpegData(compressionQuality: 0.8)
////        }
//    }
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(snooze, forKey: .snooze)
//        try container.encode(name, forKey: .name)
//        try container.encode(sound, forKey: .sound)
//        try container.encode(fk_weather, forKey: .fk_weather)
//    }
//    
//}
//
//
////_________________________________________________________________________________________
//@Model
//class Weather: Codable{
//    
////    @Attribute(.unique)
//    var type: String
//    var temperature: Int
//    var alarmS_weather: [Alarm_Weather]?
//    
//    enum CodingKeys: String, CodingKey {
//        case type
//        case temperature
//    }
//    
//    init(type: String, temperature: Int, alarm_weather: [Alarm_Weather]? = nil) {
//        self.type = type
//        self.temperature = temperature
//    }
//    
//    required init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.type = try container.decode(String.self, forKey: .type)
//        self.temperature = try container.decode(Int.self, forKey: .temperature)
//    }
//    
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(type, forKey: .type)
//        try container.encode(temperature, forKey: .temperature)
//    }
//    
//}
//
//
////_________________________________________________________________________________________
//@Model
//class Location: Codable{
//    
//    @Attribute(.unique)
//    var postCode: Int
//    var street: String
//    var num: Int
//    var alarmS_weather: [Alarm_Weather]?
//    var alarmS_locationStart: [Alarm_Location]?
//    var alarmS_locationFinish: [Alarm_Location]?
//    
//    enum CodingKeys: String, CodingKey {
//        case postCode
//        case street
//        case num
//    }
//    
//    init(postCode: Int, street: String, num: Int, alarmS_weather: [Alarm_Weather]? = nil, alarmS_locationStart: [Alarm_Location]? = nil, alarmS_locationFinish: [Alarm_Location]? = nil) {
//        self.postCode = postCode
//        self.street = street
//        self.num = num
//        self.alarmS_weather = alarmS_weather
//        self.alarmS_locationStart = alarmS_locationStart
//        self.alarmS_locationFinish = alarmS_locationFinish
//    }
//    
//    required init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.street = try container.decode(String.self, forKey: .street)
//        self.postCode = try container.decode(Int.self, forKey: .postCode)
//        self.num = try container.decode(Int.self, forKey: .num)
//    }
//    
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(street, forKey: .street)
//        try container.encode(postCode, forKey: .postCode)
//        try container.encode(num, forKey: .num)
//    }
//    
//}

//
//@Model
//final class Alarm_Location :Codable {
//    
//    var snooze: Bool
//    var name: String
//    var sound: String
//    
//    @Relationship(deleteRule: .nullify, inverse: \Location.alarmS_locationStart)
//    var locationStart: Location?
//    
//    @Relationship(deleteRule: .nullify, inverse: \Location.alarmS_locationFinish)
//    var locationFinish: Location?
//   
//    
//    enum CodingKeys: String, CodingKey {
//        case snooze
//        case name
//        case sound
//        case locationStart
//        case locationFinish
//        
//    }
//    
//    init(snooze: Bool, name: String, sound: String, locationStart: Location? = nil, locationFinish: Location? = nil) {
//        self.snooze = snooze
//        self.name = name
//        self.sound = sound
//        self.locationStart = locationStart
//        self.locationFinish = locationFinish
//    }
//    
//    
//   init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.snooze = try container.decode(Bool.self, forKey: .snooze)
//        self.name = try container.decode(String.self, forKey: .name)
//        self.sound = try container.decode(String.self, forKey: .sound)
//        self.locationStart = try container.decodeIfPresent(Location.self, forKey: .locationStart)
//       self.locationFinish = try container.decodeIfPresent(Location.self, forKey: .locationFinish)
////        self.category = try container.decodeIfPresent(Category.self, forKey: .category)
////
////        if let imageName = try container.decodeIfPresent(String.self, forKey: .imageName),
////           let imageData = UIImage(named: imageName) {
////            self.image = imageData.jpegData(compressionQuality: 0.8)
////        }
//    }
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(snooze, forKey: .snooze)
//        try container.encode(name, forKey: .name)
//        try container.encode(sound, forKey: .sound)
//        try container.encode(locationStart, forKey: .locationStart)
//        try container.encode(locationFinish, forKey: .locationFinish)
//    }
//    
//}
//
//
//
