//
//  HomePageVC.swift
//  CyCoin
//
//  Created by Terry Kuo on 2021/5/16.
//
//API call
//Custom Cell

import UIKit

class HomePageVC: UIViewController {
    
    
    //MARK: - Properties
    private var data: [CryptoResponse] = []
    var refreshControl = UIRefreshControl()
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(CryptoListCell.self, forCellReuseIdentifier: CryptoListCell.reuseID)
        return table
    }()
    
    
    
    
    
    //MARK: - Apps Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        getCurrency()
        configureHomePageVC()
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.bounds
    }
    
    
    
    //MARK: - UI layout
    private func configureHomePageVC() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.rowHeight = 50
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: .zero)
        
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    
    
    
    //MARK: - Functional
    private func getCurrency() {
        showLoadingView()
        NetworkManager.shared.getCurrency(from: .cryptoTracker) { [weak self](results: Result<[CryptoResponse], APIError>) in
            guard let self = self else { return }
            switch results {
            
            case .success(let data):
                self.data = data
                DispatchQueue.main.async {
                    self.dimissLoadingView()
                    self.refreshControl.endRefreshing()
                    self.configureTableView()
                }
                
            case .failure(let apiError):
                print(apiError.rawValue)
            }
        }
    }
    
    @objc func refresh(_ sender: AnyObject) {
       // Code to refresh table view
        print("refreshing....")
        getCurrency()
    }

}


//MARK: - UITableViewDelegate, DataSource
extension HomePageVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CryptoListCell.reuseID, for: indexPath) as? CryptoListCell else {
            fatalError()
        }
        cell.set(data: self.data, indexPath: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}
