//
//  AppSettings.swift
//  Weather
//
//  Created by Mohammed Abubaker on 05/03/2022.
//

import UIKit

class AppSettings: NSObject {
    
    static let shared:AppSettings = AppSettings()
    
    private let kTemperatureUnit = "kTemperatureUnit"
    
    var temperatureUnit: Constants.Units {
        get {
            let value = UserDefaults.standard.string(forKey: kTemperatureUnit) ?? ""
            let unit = Constants.Units.init(rawValue: value)
            return unit ?? .Fahrenheit
        }
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: kTemperatureUnit)
        }
    }
    
    func getTemperature(_ temp: Double) -> Double {
        switch temperatureUnit {
        case .Fahrenheit:
            return temp * (9/5) - 459.67
        case .Celsius:
            return temp - 273.15
        }
    }
    
}
