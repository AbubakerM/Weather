//
//  WeatherList.swift
//  Weather
//
//  Created by 118 on 2022/3/5.
//

import Foundation
import RealmSwift

@objcMembers class WeatherList: Object, Decodable {
    var listPKey = "listPKey"
    dynamic var lat: Double = 0
    dynamic var lon: Double = 0
    dynamic var timezone: String = ""
    dynamic var timezoneOffset: Int = 0
    dynamic var current: Current?
    //dynamic var minutely: [Minutely]
    //dynamic var hourly: [Current]
    var daily = List<Daily>()

    enum CodingKeys: String, CodingKey {
        case lat, lon, timezone
        case timezoneOffset = "timezone_offset"
        case current
        //case minutely
        //case hourly
        case daily
    }
    
    override class func primaryKey() -> String? {
        return "listPKey"
    }
    
}


// MARK: - Current
@objcMembers class Current: Object, Codable {
    dynamic var dt: Int = 0
    dynamic var sunrise: Int = 0
    dynamic var sunset: Int = 0
    dynamic var temp: Double = 0
    dynamic var feelsLike: Double = 0
    dynamic var pressure: Int = 0
    dynamic var humidity: Int = 0
    dynamic var dewPoint: Double = 0
    dynamic var uvi: Double = 0
    dynamic var visibility: Int = 0
    dynamic var clouds: Int = 0
    dynamic var windSpeed: Double = 0
    dynamic var windDeg: Int = 0
    var weather = List<Weather>()

    enum CodingKeys: String, CodingKey {
        case dt, sunrise, sunset, temp
        case feelsLike = "feels_like"
        case pressure, humidity
        case dewPoint = "dew_point"
        case uvi, clouds, visibility
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case weather
    }
}

// MARK: - Weather
@objcMembers class Weather: Object, Codable {
    dynamic var id: Int = 0
    dynamic var main: String = ""
    dynamic var weatherDescription: String = ""
    dynamic var icon: String = ""

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
    
}

// MARK: - Daily
@objcMembers class Daily: Object, Codable {
    dynamic var dt: Int = 0
    dynamic var sunrise: Int = 0
    dynamic var sunset: Int = 0
    dynamic var moonrise: Int = 0
    dynamic var moonset: Int = 0
    dynamic var moonPhase: Double = 0
    dynamic var temp: Temp?
    dynamic var feelsLike: FeelsLike?
    dynamic var pressure: Int = 0
    dynamic var humidity: Int = 0
    dynamic var dewPoint: Double = 0
    dynamic var windSpeed: Double = 0
    dynamic var windDeg: Int = 0
    dynamic var windGust: Double = 0
    var weather = List<Weather>()
    dynamic var clouds: Int = 0
    dynamic var uvi: Double = 0

    enum CodingKeys: String, CodingKey {
        case dt, sunrise, sunset, moonrise, moonset
        case moonPhase = "moon_phase"
        case temp
        case feelsLike = "feels_like"
        case pressure, humidity
        case dewPoint = "dew_point"
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case windGust = "wind_gust"
        case weather, clouds, uvi
    }
    
}

// MARK: - FeelsLike
@objcMembers class FeelsLike: Object, Codable {
    dynamic var day: Double = 0
    dynamic var night: Double = 0
    dynamic var eve: Double = 0
    dynamic var morn: Double = 0
    
}

// MARK: - Temp
@objcMembers class Temp: Object, Codable {
    dynamic var day: Double = 0
    dynamic var min: Double = 0
    dynamic var max: Double = 0
    dynamic var night: Double = 0
    dynamic var morn: Double = 0
    dynamic var eve: Double = 0
    
}

// MARK: - Minutely
@objcMembers class Minutely: Object, Codable {
    dynamic var dt: Int = 0
    dynamic var precipitation: Int = 0
    
}




