//
//  APIModelsMapper.swift
//  Weather
//
//  Created by 118 on 2022/3/5.
//

import Foundation

final class APIModelsMapper {
        
    static func map<T: Decodable>(_ data: Data) -> T? {
        do {
            let object = try JSONDecoder().decode(T.self, from: data)
            print("🚧🚧",object,"🚧🚧")
            return object
        } catch {
            print("🚧🚧",error,"🚧🚧")
            return nil
        }
    }
}
