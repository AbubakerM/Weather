//
//  Constants+API.swift
//  Weather
//
//  Created by 118 on 2022/3/5.
//

import Foundation

enum HttpMethod : String {
    case get     = "GET"
    case post    = "POST"
    case put     = "PUT"
    case delete  = "Delete"
}

extension Constants.API {
    enum Path: String {
        case onecall = "/data/2.5/onecall"
    }
}
