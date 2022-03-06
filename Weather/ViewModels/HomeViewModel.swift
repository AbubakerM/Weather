//
//  WeatherListViewModel.swift
//  Weather
//
//  Created by 118 on 2022/3/5.
//

import Foundation

typealias UpdateHendler = ((UpdateStatus) -> Void)

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
    
    func getWeatherList(completion: UpdateHendler? = nil) {
        guard
            let lat = LocationManager.shared.getCurrentLocation()?.latitude.description ,
            let lon = LocationManager.shared.getCurrentLocation()?.longitude.description
        else { return }
        
        let params = [
            "lat":lat,
            "lon":lon,
            "appid": Constants.API.Key
        ]
        
        let endpoint = APIEndPoint(path: .onecall, method: .get, parameters: params)
                
        let service = WeatherService(endPoint: endpoint)
        service.getWeatherList { [weak self] weatherList in
            guard let self = self else { return }
            DispatchQueue.main.async {
                if let list = weatherList {
                    self.setData(listObject: list)
                    RealmHelper.shared.insert(list)
                    completion?(.success)
                } else {
                    //Check Offline Data
                    if let offlineList: WeatherList = RealmHelper.shared.fetch() {
                        self.setData(listObject: offlineList)
                    }
                    completion?(.failure)
                }
            }
        }
    }
    
}
