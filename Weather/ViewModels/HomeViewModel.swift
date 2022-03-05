//
//  WeatherListViewModel.swift
//  Weather
//
//  Created by 118 on 2022/3/5.
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
        
        windSpeed = String(format: "%.2f", object.windSpeed ?? 0)
        humidity = String(object.humidity ?? 0)
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
        temp = (maxTemp ?? "") + " / " + (minTemp ?? "") + " " + AppSettings.shared.temperatureUnit.rawValue
    }
    
    private func calculateMinTemp(_ temp: Double) -> String {
        let temp = AppSettings.shared.getTemperature(temp)
        return String(format: "%.0f", temp)
    }
    
    private func calculateMaxTemp(_ temp: Double) -> String {
        let temp = AppSettings.shared.getTemperature(temp)
        return String(format: "%.0f", temp)
    }
    
}

class HomeViewModel {
    
    var timeZone = ""
    
    var object: WeatherList?
    
    var list = [HomeCellViewModel]() {
        didSet {
            reload?()
        }
    }
    
    var reload: (() -> Void)?
    
    private func setData(listObject: WeatherList) {
        object = listObject
        timeZone = listObject.timezone ?? ""
        reloadViewModels()
    }
    
    func reloadViewModels() {
        var forecast = [HomeCellViewModel]()
        
        if let object = object {
            object.daily.forEach({ daily in
                let viewModel = HomeCellViewModel(object: daily)
                forecast.append(viewModel)
            })
            self.list.removeAll()
            self.list = forecast
        }
        
    }
    
    func getWeatherList() {
        let params = [
            "lat":"25.191116",
            "lon":"55.272355",
            "appid": Constants.API.Key
        ]
        
        let endpoint = APIEndPoint(path: .onecall, method: .get, parameters: params)
                
        let service = WeatherService(endPoint: endpoint)
        service.getWeatherList { [weak self] weatherList in
            guard let self = self else { return }
            if let list = weatherList {
                self.setData(listObject: list)
            }
        }
    }
    
}
