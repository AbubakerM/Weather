//
//  APIModelsMapper.swift
//  Weather
//
//  Created by 118 on 2022/3/5.
//

import Foundation

final class APIModelsMapper {
        
    static func map<T: Codable>(_ data: Data) -> T? {
        
        let root = try? JSONDecoder().decode(T.self, from: data)
        
        return root
    }
    
}
