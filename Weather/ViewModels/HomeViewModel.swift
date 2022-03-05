//
//  WeatherListViewModel.swift
//  Weather
//
//  Created by 118 on 2022/3/5.
//

import Foundation

class HomeViewModel {
        
    var object: WeatherList?

    var list = [HomeCellViewModel]() {
        didSet {
            reload?()
        }
    }
        
    var reload: (() -> Void)?
    
    private func setData(listObject: WeatherList) {
        object = listObject
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
    
    func getDetailsList(_ index: Int) -> [DetailsCellViewModel] {
        let homeViewModel = list[index]
        let maxTemp = DetailsCellViewModel(title: "Max Temperature", value: homeViewModel.maxTemp)
        let minTemp = DetailsCellViewModel(title: "Min Temperature", value: homeViewModel.minTemp)
        let humidity = DetailsCellViewModel(title: "Humidity", value: homeViewModel.humidity)
        let wind = DetailsCellViewModel(title: "Wind", value: homeViewModel.windSpeed)
        return [maxTemp,minTemp,humidity,wind]
    }
    
    func getWeatherList() {
        guard
            let lat = LocationManager.shared.getCurrentLocation()?.latitude.description ,
            let lon = LocationManager.shared.getCurrentLocation()?.longitude.description
        else {
            LocationManager.shared.askLocationAutorization()
            return }
        
        let params = [
            "lat":lat,
            "lon":lon,
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
