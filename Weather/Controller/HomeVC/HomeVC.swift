//
//  HomeVC.swift
//  Weather
//
//  Created by 118 on 2022/3/5.
//

import UIKit

protocol ViewConfiguration {
    func initView()
}

class HomeVC: UIViewController, ViewConfiguration {

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
                self?.title = self?.viewModel.object?.timezone
                self?.tableView.reloadData()
            }
        }
    }
    
    @IBAction func settingsClicked(_ sender: Any) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "SettingsVC") as? SettingsVC else { return }
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeVC: SettingsProtocol {
    func settingsChanged() {
        viewModel.reloadViewModels()
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailsVC") as? DetailsVC else { return }
        vc.viewModelList = viewModel.getDetailsList(indexPath.row)
        navigationController?.pushViewController(vc, animated: true)
    }
}
