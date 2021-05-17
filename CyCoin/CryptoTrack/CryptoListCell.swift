//
//  CryptoListCell.swift
//  CyCoin
//
//  Created by Terry Kuo on 2021/5/16.
//

import UIKit

class CryptoListCell: UITableViewCell {
    
    static let reuseID = "cryptoListID"
    
    static let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.locale = .current
        formatter.maximumFractionDigits = 5
        formatter.numberStyle = .currency
        return formatter
    }()
    
    let logoImage = UIImageView(frame: .zero)
    let cryptoName = CyTrackerLabel(textSize: 18, textAlignment: .left, textColor: .label)
    let idLabel = CyTrackerLabel(textSize: 15, textAlignment: .left, textColor: .gray)
    let dollar = CyTrackerLabel(textSize: 20, textAlignment: .right, textColor: .systemGreen)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureImage()
        configure()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(data: [CryptoResponse], indexPath: Int) {
        let number = NSNumber(value: data[indexPath].price_usd)
        let string = Self.formatter.string(from: number)
        dollar.text = string
        cryptoName.text = data[indexPath].name
        idLabel.text = data[indexPath].asset_id
    }
    
    
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
        logoImage.image = UIImage(named: "Dogecoin_Logo")
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        addSubview(logoImage)
        
        NSLayoutConstraint.activate([
            logoImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            logoImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            logoImage.heightAnchor.constraint(equalTo: self.heightAnchor),
            logoImage.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    
    
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
