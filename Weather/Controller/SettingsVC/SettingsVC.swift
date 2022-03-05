//
//  SettingsVC.swift
//  Weather
//
//  Created by Mohammed Abubaker on 05/03/2022.
//

import UIKit

protocol SettingsProtocol: AnyObject {
    func settingsChanged()
}

class SettingsVC: UIViewController {

    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    weak var delegate: SettingsProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setSegmentControl()
        
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
        setSegmentControl()
        delegate?.settingsChanged()
    }
    
    func setSegmentControl() {
        segmentControl.selectedSegmentIndex = AppSettings.shared.temperatureUnit == .Fahrenheit ? 0 : 1
    }
    
}
