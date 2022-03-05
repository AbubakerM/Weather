//
//  HomeVC.swift
//  Weather
//
//  Created by 118 on 2022/3/5.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Home"
        
        tableView.registerNib(HomeCell.identifier)
    }

}
