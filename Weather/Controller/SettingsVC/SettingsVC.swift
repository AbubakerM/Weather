//
//  SettingsVC.swift
//  Weather
//
//  Created by Mohammed Abubaker on 05/03/2022.
//

import UIKit

class SettingsVC: UIViewController {

    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateTempSettings(AppSettings.shared.temperatureUnit)
        
    }

    @IBAction func indexChanged(_ sender: Any) {
        switch segmentControl.selectedSegmentIndex
        {
        case 0:
            updateTempSettings(.Fahrenheit)
        case 1:
            updateTempSettings(.Celsius)
        default:
            break
        }
    }
    
    func updateTempSettings(_ unit: Constants.Units) {
        AppSettings.shared.temperatureUnit = unit
        
        switch unit {
        case .Celsius:
            segmentControl.selectedSegmentIndex = 1
        case .Fahrenheit:
            segmentControl.selectedSegmentIndex = 0
        }
    }
    
}
