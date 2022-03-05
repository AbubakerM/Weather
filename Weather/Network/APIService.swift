//
//  APIService.swift
//  Weather
//
//  Created by 118 on 2022/3/5.
//

import Foundation

typealias ServiceResult = (Result<(Data, HTTPURLResponse), Error>) -> Void

protocol Service {
    func request(_ request: URLRequest, completion: @escaping (Result<(Data, HTTPURLResponse), Error>) -> Void)
}

class APIService: Service {
    
    private let session: URLSession
    
    init() {
        session = URLSession(configuration: .default)
    }
    
    func request(_ request: URLRequest, completion: @escaping ServiceResult) {
        session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data, let response = response as? HTTPURLResponse {
                print(response.description)
                completion(.success((data,response)))
            }
        }.resume()
    }
}
