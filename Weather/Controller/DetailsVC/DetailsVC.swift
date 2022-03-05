//
//  DetailsVC.swift
//  Weather
//
//  Created by 118 on 2022/3/5.
//

import UIKit

class DetailsVC: UIViewController, ViewConfiguration {

    @IBOutlet weak var tableView: UITableView!
    
    var viewModelList = [DetailsCellViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
    }
    
    func initView() {
        title = "Info"
        
        tableView.registerNib(DetailsCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
    }

}

extension DetailsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModelList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailsCell.identifier, for: indexPath) as? DetailsCell else {
            return UITableViewCell()
        }
        
        cell.setup(object: viewModelList[indexPath.row])
        
        return cell
    }
}
