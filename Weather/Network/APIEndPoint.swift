//
//  APIEndPoint.swift
//  Weather
//
//  Created by 118 on 2022/3/5.
//

import Foundation

protocol Endpoint {
    var path: String { get }
    var method : String {get}
    var url: URL! { get }
    var parameters: [String:String]? { get }
    var httpRequest : URLRequest! {get}
}

public struct APIEndPoint: Endpoint {
    
    var path: String
    var method: String
    
    var parameters: [String : String]?
    
    var url: URL! {
        get {
            var components = URLComponents()
            components.scheme = "https"
            components.host = "api.openweathermap.org"
            components.path = path
            
            return components.url
        }
    }
    
    var httpRequest: URLRequest! {
        var request : URLRequest = URLRequest(url: self.url)
        
        request.httpMethod = self.method
        request.timeoutInterval = 15
        
        return request
    }
    
    init(
        path: String,
        method: String,
        parameters: [String : String]? = nil)
    {
        self.path = path
        self.method = method
        self.parameters = parameters
    }
    
}
