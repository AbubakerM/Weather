//
//  APIModelsMapper.swift
//  Weather
//
//  Created by 118 on 2022/3/5.
//

import Foundation

typealias MappingResult<T> = Swift.Result<T, Error>

final class APIModelsMapper {
        
    static func map<T: Codable>(_ data: Data) -> T? {
        
        let object = try? JSONDecoder().decode(T.self, from: data)
        
        return object
    }
    
}
