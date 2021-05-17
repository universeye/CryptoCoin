//
//  CyTrackerLabel.swift
//  CyCoin
//
//  Created by Terry Kuo on 2021/5/16.
//

import UIKit

class CyTrackerLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(textSize: CGFloat, textAlignment: NSTextAlignment, textColor: UIColor) {
        self.init(frame: .zero)
        self.font = UIFont.systemFont(ofSize: textSize, weight: .semibold)
        self.textAlignment = textAlignment
        self.textColor = textColor
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        adjustsFontSizeToFitWidth = true
        
    }
    
}
