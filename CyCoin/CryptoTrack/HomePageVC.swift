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
    private var refreshControl = UIRefreshControl()
    
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(CryptoListCell.self, forCellReuseIdentifier: CryptoListCell.reuseID)
        return table
    }()
    
    
    //MARK: - Apps Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ///PersistanceManager.shared.cryptoCoinArray = []
        #warning("Save the coredata's set into persistenceManager")
        
        getCurrency() {}
        configureHomePageVC()
        //configureTableView()
        NetworkManager.shared.getImageURL {
            print("finish getting img url")
            DispatchQueue.main.async {
                self.configureTableView()
                self.dimissLoadingView()
            }
            
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.bounds
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }
    
    //MARK: - UI layout
    private func configureHomePageVC() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let alertbutton = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(presentalert))
        navigationItem.leftBarButtonItem = alertbutton
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItems))
        navigationItem.rightBarButtonItem = addButton
    }
    
    @objc func presentalert() {
        self.presentAlertView()
    }
    
    @objc func addItems() {
        self.presentCoinPicker()
    }
    
    func presentCoinPicker() {
        DispatchQueue.main.async {
            let pickerView = CoinPickerVC()
            pickerView.delegate = self
            pickerView.modalTransitionStyle = .coverVertical
            pickerView.modalPresentationStyle = .overFullScreen
            self.present(pickerView, animated: true, completion: nil)
        }
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.rowHeight = 60
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: .zero)
        
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    
    
    
    //MARK: - Functional
    private func getCurrency(completion: @escaping () -> Void) {
        DispatchQueue.main.async {
            self.showLoadingView()
        }
        
        NetworkManager.shared.getCurrency(from: .cryptoTracker) { [weak self](results: Result<[CryptoResponse], APIError>) in
            guard let self = self else { return }
            switch results {
            
            case .success(let data):
                self.data = data.sorted(by: { first, second -> Bool in
                    return first.price_usd ?? 0 > second.price_usd ?? 0
                })
                DispatchQueue.main.async {
                    //self.dimissLoadingView()
                    self.refreshControl.endRefreshing()
                    self.tableView.reloadData()
                    completion()
                }
                
            case .failure(let apiError):
                DispatchQueue.main.async {
                    //self.dimissLoadingView()
                    self.refreshControl.endRefreshing()
                    completion()
                }
                self.presentAlertView()
                print("Error getting currency: \(apiError.rawValue)")
            }
        }
    }
    
    @objc func refresh(_ sender: AnyObject) {
        // Code to refresh table view
        print("refreshing....")
        getCurrency() {
            DispatchQueue.main.async {
                self.dimissLoadingView()
            }
        }
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
        cell.set(
            data: self.data,
            indexPath: indexPath.row
        )
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //delete coin
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard  editingStyle == .delete else {
            return
        }
        
        PersistanceManager.shared.cryptoCoinArray.remove(data[indexPath.row].asset_id)
        #warning("save the array to coredata here")
        getCurrency() {
            DispatchQueue.main.async {
                self.dimissLoadingView()
            }
        }
    }
    
}


//MARK: - CoinPickerVCDelegate
extension HomePageVC: CoinPickerVCDelegate {
    func didAddCoin() {
        getCurrency() {
            DispatchQueue.main.async {
                self.dimissLoadingView()
            }
        }
    }
    
    
}
