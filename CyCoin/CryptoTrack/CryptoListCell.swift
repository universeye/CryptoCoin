//
//  CryptoListCell.swift
//  CyCoin
//
//  Created by Terry Kuo on 2021/5/16.
//

import UIKit

class CryptoListCell: UITableViewCell {
    
    static let reuseID = "cryptoListID"
    
    
    //MARK: - Properties
    let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    
    static let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.locale = .current
        formatter.maximumFractionDigits = 5
        formatter.numberStyle = .currency
        return formatter
    }()
    
    let logoImage: UIImageView = {
        let imageview = UIImageView(frame: .zero)
        let placeholder = UIImage(named: "Dogecoin_Logo")
        imageview.image = placeholder
        imageview.translatesAutoresizingMaskIntoConstraints = false
        return imageview
    }()
    
    let cache = NetworkManager.shared.cache
    let cryptoName = CyTrackerLabel(textSize: 18, textAlignment: .left, textColor: .label)
    let idLabel = CyTrackerLabel(textSize: 15, textAlignment: .left, textColor: .gray)
    let dollar = CyTrackerLabel(textSize: 20, textAlignment: .right, textColor: .systemGreen)
    
    
    //MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureImage()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(data: [CryptoResponse], indexPath: Int) {
        let number = NSNumber(value: data[indexPath].price_usd ?? 1)
        let string = Self.formatter.string(from: number)
        dollar.text = string
        cryptoName.text = data[indexPath].name
        idLabel.text = data[indexPath].asset_id
        
        if let imageUrl = NetworkManager.shared.imageURLViewModel[data[indexPath].asset_id] {
            self.downloadImage(from: imageUrl)
        }
    }
    
    
    
    //MARK: - Configuring UI
    private func configure() {
        addSubview(cryptoName)
        addSubview(dollar)
        addSubview(idLabel)
        
        NSLayoutConstraint.activate([
            cryptoName.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            cryptoName.leadingAnchor.constraint(equalTo: logoImage.trailingAnchor, constant: 5),
            cryptoName.heightAnchor.constraint(equalToConstant: 20),
            cryptoName.widthAnchor.constraint(equalToConstant: 80),
            
            idLabel.topAnchor.constraint(equalTo: cryptoName.bottomAnchor, constant: 5),
            idLabel.leadingAnchor.constraint(equalTo: logoImage.trailingAnchor, constant: 5),
            idLabel.heightAnchor.constraint(equalToConstant: 20),
            idLabel.widthAnchor.constraint(equalToConstant: 40),
            
            dollar.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            dollar.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            dollar.heightAnchor.constraint(equalToConstant: 30),
            dollar.widthAnchor.constraint(equalToConstant: 180)
        ])
    }
    
    private func configureImage() {
        addSubview(logoImage)
        
        NSLayoutConstraint.activate([
            logoImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            logoImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            logoImage.heightAnchor.constraint(equalTo: self.heightAnchor, constant: -10),
            logoImage.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    //MARK: - Functional
    func downloadImage(from urlString: String) {
        DispatchQueue.main.async {
            self.showImageLoadingView()
        }
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            DispatchQueue.main.async {
                self.logoImage.image = image
                self.dismissLoadingView()
            }
            
        } else {
            guard let url = URL(string: urlString) else {
                print("Invalid URL")
                return }
            
            let task = URLSession.shared.dataTask(with: url) {  [weak self] (data, response, error) in
                guard let self = self else { return }
                if error != nil {
                    print(error?.localizedDescription ?? "error not nil")
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    print("Failed response")
                    return
                }
                
                guard let data = data else {
                    print("no data")
                    return
                }
                guard let image = UIImage(data: data) else {
                    print("no image")
                    return
                }
                
                self.cache.setObject(image, forKey: cacheKey)
                DispatchQueue.main.async {
                    self.dismissLoadingView()
                    self.logoImage.image = image
                }
            }
            task.resume()
        }
    }
    
    
    //MARK: - Image Loading View
    func showImageLoadingView() {
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
        loadingIndicator.layer.cornerRadius = loadingIndicator.frame.size.width/2
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating()
        
        logoImage.addSubview(loadingIndicator)
        
        NSLayoutConstraint.activate([
            loadingIndicator.centerYAnchor.constraint(equalTo: logoImage.centerYAnchor),
            loadingIndicator.centerXAnchor.constraint(equalTo: logoImage.centerXAnchor)
        ])
        
    }
    
    func dismissLoadingView() {
        loadingIndicator.removeFromSuperview()
    }
}
