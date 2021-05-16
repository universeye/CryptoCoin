//
//  CyLabel.swift
//  CyCoin
//
//  Created by Terry Kuo on 2021/5/14.
//

import UIKit

class CyLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        
        textAlignment = .center
        font = .systemFont(ofSize: 42, weight: .bold)
        textColor = .white
        //backgroundColor = .gray
        layer.cornerRadius = 40
        layer.backgroundColor = UIColor.black.cgColor
    }
    

}
