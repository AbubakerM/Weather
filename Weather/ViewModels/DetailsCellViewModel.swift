//
//  DetailsCellViewModel.swift
//  Weather
//
//  Created by Mohammed Abubaker on 05/03/2022.
//

import Foundation

class DetailsCellViewModel {
    var title: String?
    var value: String?
    
    init(title: String?, value: String?) {
        self.title = title
        self.value = value
    }
}
