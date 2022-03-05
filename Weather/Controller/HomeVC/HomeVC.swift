//
//  HomeVC.swift
//  Weather
//
//  Created by 118 on 2022/3/5.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    lazy var viewModel = {
        HomeViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        initViewModel()
    }
    
    func initView() {
        title = "Home"
        
        tableView.registerNib(HomeCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func initViewModel() {
        // Get Weather list
        viewModel.getWeatherList()
        
        // Reload TableView closure
        viewModel.reload = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeCell.identifier, for: indexPath) as? HomeCell else {
            return UITableViewCell()
        }
        
        cell.initialize(viewModel.list[indexPath.row])
        
        return cell
    }
}
