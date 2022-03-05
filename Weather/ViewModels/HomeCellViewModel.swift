//
//  HomeCellViewModel.swift
//  Weather
//
//  Created by Mohammed Abubaker on 06/03/2022.
//

import Foundation

class HomeCellViewModel {
    var date: String?
    var temp: String?
    var minTemp: String?
    var maxTemp: String?
    var windSpeed: String?
    var humidity: String?
    
    init(object: Daily) {
        date = getStringDate(object.dt ?? 0)
        
        setMinMaxTemp(max: object.temp.max, min: object.temp.min)
        
        windSpeed = String(format: "%.2f", object.windSpeed ?? 0) + "m/s"
        humidity = String(object.humidity ?? 0)+"%"
    }
    
    private func getStringDate(_ milliseconds: Int) -> String {
        let d = Date(timeIntervalSince1970: TimeInterval(milliseconds))
        let df = DateFormatter()
        df.locale = Locale(identifier: "en")
        df.dateFormat = "y-MM-dd"
        
        return df.string(from: d)
    }
    
    private func setMinMaxTemp(max: Double?, min: Double?) {
        minTemp = calculateMinTemp(min ?? 0)
        maxTemp = calculateMaxTemp(max ?? 0)
        temp = (maxTemp ?? "") + " / " + (minTemp ?? "")
    }
    
    private func calculateMinTemp(_ temp: Double) -> String {
        let temp = AppSettings.shared.getTemperature(temp)
        return String(format: "%.0f", temp) + " " + AppSettings.shared.temperatureUnit.rawValue
    }
    
    private func calculateMaxTemp(_ temp: Double) -> String {
        let temp = AppSettings.shared.getTemperature(temp)
        return String(format: "%.0f", temp) + " " + AppSettings.shared.temperatureUnit.rawValue
    }
    
}
