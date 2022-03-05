//
//  WeatherService.swift
//  Weather
//
//  Created by 118 on 2022/3/5.
//

import Foundation


class WeatherService {
    
    private let service: APIService
    private var endPoint: APIEndPoint
    
    init(endPoint: APIEndPoint) {
        self.service = APIService()
        self.endPoint = endPoint
    }
    
    func updateList(completion: @escaping (WeatherList?) -> Void) {
        
        service.request(endPoint.httpRequest) { result in
            switch result {
            case .failure:completion(nil)
            case let .success((data, _)):
                
                guard let weatherList:WeatherList = APIModelsMapper.map(data) else {
                    return completion(nil)
                }
                
                completion(weatherList)
                
            
            }
        }
    }
    
}
