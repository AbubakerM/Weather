//
//  HomeCell.swift
//  Weather
//
//  Created by 118 on 2022/3/5.
//

import UIKit

class HomeCell: UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    func initialize(_ object: HomeCellViewModel) {
        dateLabel.text = object.date
        tempLabel.text = object.temp
//        maxTempLabel.text = object.maxTemp
//        minTempLabel.text = object.minTemp
//        humidityLabel.text = object.humidity
//        windSpeedLabel.text = object.windSpeed
    }
    
}
