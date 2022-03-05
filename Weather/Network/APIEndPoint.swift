//
//  APIEndPoint.swift
//  Weather
//
//  Created by 118 on 2022/3/5.
//

import Foundation

protocol Endpoint {
    var path: String { get }
    var method : HttpMethod {get}
    var url: URL! { get }
    var parameters: [String:String]? { get }
    var httpRequest : URLRequest! {get}
}

public struct APIEndPoint: Endpoint {
    
    init(
        path: Constants.API.Path,
        method: HttpMethod,
        parameters: [String : String]? = nil)
    {
        self.path = path.rawValue
        self.method = method
        self.parameters = parameters
    }
    
    var path: String
    var method: HttpMethod
    
    var parameters: [String : String]?
    
    var url: URL! {
        get {
            var components = URLComponents()
            components.scheme = Constants.API.Scheme
            components.host = Constants.API.BaseURL
            components.path = path
            components.queryItems = method == .get ? getQueryItems() : nil
            
            return components.url
        }
    }
    
    var httpRequest: URLRequest! {
        var request : URLRequest = URLRequest(url: self.url)
        
        if method == .post {
            if let body = getRequestBody() {
                request.httpBody = body
            }
        }
        
        request.httpMethod = self.method.rawValue
        request.timeoutInterval = Constants.API.kTimeOutInterval
        
        return request
    }
    
    // MARK: - Helpers
    
    private func getQueryItems() -> [URLQueryItem] {
        guard let parameters = parameters else {
            return []
        }

        var queryItems = [URLQueryItem]()
        for (key,value) in parameters {
            let item = URLQueryItem(name: key, value: value)
            queryItems.append(item)
        }
        return queryItems
    }
    
    private func getRequestBody() -> Data? {
        guard let parameters = parameters,
              parameters.keys.count > 0 else {
                  return nil
              }
        
        let json = parameters.jsonString
        return Data(base64Encoded: json)
    }
}
