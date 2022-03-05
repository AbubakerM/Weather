//
//  WeatherListViewModel.swift
//  Weather
//
//  Created by 118 on 2022/3/5.
//

import Foundation

class HomeCellViewModel {
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

class HomeViewModel {
    
    var timeZone = ""
    var list = [HomeCellViewModel]() {
        didSet {
            reload?()
        }
    }
    
    var reload: (() -> Void)?
    
    private func setData(listObject: WeatherList) {
        timeZone = listObject.timezone ?? ""
        
        var forecast = [HomeCellViewModel]()
        listObject.daily.forEach({ daily in
            let viewModel = HomeCellViewModel(object: daily)
            forecast.append(viewModel)
        })
        self.list = forecast
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
