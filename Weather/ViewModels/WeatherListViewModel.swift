//
//  WeatherListViewModel.swift
//  Weather
//
//  Created by 118 on 2022/3/5.
//

import Foundation

class WeatherViewModel {
    var date: String?
    var minTemp: String?
    var maxTemp: String?
    var windSpeed: String?
    var humidity: String?
    
    init(object: Daily) {
        date = getStringDate(object.dt ?? 0)
        minTemp = String(format: "%.2f", object.temp.min ?? 0)
        maxTemp = String(format: "%.2f", object.temp.max ?? 0)
        windSpeed = String(format: "%.2f", object.windSpeed ?? 0)
        humidity = String(object.humidity ?? 0)
    }
    
    private func getStringDate(_ milliseconds: Int) -> String {
        let d = Date(timeIntervalSince1970: TimeInterval(milliseconds))
        let df = DateFormatter()
        df.dateFormat = "y-MM-dd"
        
        return df.string(from: d)
    }
    
}

class WeatherListViewModel {
    var timeZone: String
    var forecast: [WeatherViewModel]
    
    init(listObject: WeatherList) {
        timeZone = listObject.timezone ?? ""
        
        var forecast = [WeatherViewModel]()
        listObject.daily.forEach({ daily in
            let viewModel = WeatherViewModel(object: daily)
            forecast.append(viewModel)
        })
        self.forecast = forecast
    }
    
}
