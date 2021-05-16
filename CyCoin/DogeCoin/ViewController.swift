//
//  ViewController.swift
//  CyCoin
//
//  Created by Terry Kuo on 2021/5/14.
//

import UIKit

class ViewController: UIViewController {
    
    
    //MARK: - Properties
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(DogeTableCellTableViewCell.self, forCellReuseIdentifier: DogeTableCellTableViewCell.reuseID)
        return table
    }()
    var refreshControl = UIRefreshControl()
    
    private var viewModels = [DogeTableCellTableViewCellViewModel]()
    private var data: Datas?
    let label = CyLabel()
    
    static let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.locale = .current
        formatter.maximumFractionDigits = 3
        formatter.numberStyle = .currency
        return formatter
    }()
    
    //    static let dateFormatter: ISO8601DateFormatter = {
    //        let formatter = ISO8601DateFormatter()
    //        formatter.formatOptions = .withFractionalSeconds
    //        formatter.timeZone = .current
    //        return formatter
    //    }()
    //    static let prettydateFormatter: DateFormatter = {
    //        let formatter = DateFormatter()
    //        formatter.locale = .current
    //        formatter.timeZone = .current
    //        formatter.dateFormat = "MMM d, yyyy"
    //        return formatter
    //    }()
    
    //MARK: - App LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        getCurrency()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.bounds
    }
    
    
    
    //MARK: - Functional
    private func configureTable() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: .zero) //clear unused cell
        createTableHeader()
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    private func createTableHeader() {
        guard let price = data?._74.quote["USD"]?.price else { return }
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.width / 1.3))
        header.clipsToBounds  = true
        header.backgroundColor = .systemRed
        
        //Image
        let imageView = UIImageView(image: UIImage(named: "Dogecoin_Logo"))
        imageView.contentMode = .scaleAspectFit
        let size: CGFloat = view.frame.size.width / 3
        imageView.frame = CGRect(x: (view.frame.size.width - size) / 2, y: 10, width: size, height: size)
        header.addSubview(imageView)
        
        //label
        let number = NSNumber(value: price)
        let string = Self.formatter.string(from: number)
        label.text = string
        label.frame = CGRect(x: 10, y: 20 + size, width: view.frame.size.width - 20, height: 130)
        header.addSubview(label)
        
        
        tableView.tableHeaderView = header
    }
    
    private func getCurrency() {
        showLoadingView()
        NetworkManager.shared.getCurrency(from: .getDogeCoin) { [weak self] results in
            guard let self = self else { return }
            self.dimissLoadingView()
            switch results {
            
            case .success(let results):
                
                self.data = results.data
                DispatchQueue.main.async {
                    self.setUPviewModels()
                    self.refreshControl.endRefreshing()
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func setUPviewModels() {
        guard let model = data else {
            return
        }
        
        //guard let date = Self.dateFormatter.date(from: model._74.date_added) else { return }
        //Self.prettydateFormatter.string(from: date)
        viewModels = [DogeTableCellTableViewCellViewModel(title: "Name", value: model._74.name),
                      DogeTableCellTableViewCellViewModel(title: "Symbol", value: model._74.symbol),
                      DogeTableCellTableViewCellViewModel(title: "Identifier", value: String(model._74.id)),
                      DogeTableCellTableViewCellViewModel(title: "Date Added", value: model._74.date_added.convertToDisplayFormat()),
                      DogeTableCellTableViewCellViewModel(title: "Total Supply", value: String(model._74.total_supply))]
        
        configureTable()
    }
    
    @objc func refresh(_ sender: AnyObject) {
       // Code to refresh table view
        print("refreshing....")
        getCurrency()
    }
    
}




//MARK: - Extension

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DogeTableCellTableViewCell.reuseID, for: indexPath) as? DogeTableCellTableViewCell else {
            fatalError()
        }
        cell.configure(with: viewModels[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}
