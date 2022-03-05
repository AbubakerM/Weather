//
//  Dictionary+Extensions.swift
//  Weather
//
//  Created by 118 on 2022/3/5.
//

import Foundation

extension Dictionary {

    var jsonString:String {
        var jsonString : String = ""
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
            jsonString = String(data: jsonData, encoding: String.Encoding.utf8)! as String
        } catch {
            debugPrint(error.localizedDescription)
        }
        return jsonString
    }
    
}

