//
//  UITableView+Extensions.swift
//  Weather
//
//  Created by 118 on 2022/3/5.
//

import Foundation
import UIKit

extension UITableView {
    func registerNib(_ identifier: String) {
        let nib = UINib(nibName: identifier, bundle: nil)
        self.register(nib, forCellReuseIdentifier: identifier)
    }
}

extension UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}
