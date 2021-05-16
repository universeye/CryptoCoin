//
//  DogeTableCellTableViewCell.swift
//  CyCoin
//
//  Created by Terry Kuo on 2021/5/14.
//

import UIKit

struct DogeTableCellTableViewCellViewModel {
    let title: String
    let value: String
}

class DogeTableCellTableViewCell: UITableViewCell {
    
    static let reuseID = "DogeTableViewCell"
    
    private let label: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let valuelabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(label)
        contentView.addSubview(valuelabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.sizeToFit()
        valuelabel.sizeToFit()
        label.frame = CGRect(x: 15, y: 0, width: label.frame.size.width, height: contentView.frame.size.height)
        valuelabel.frame = CGRect(
            x: contentView.frame.size.width - 15 - valuelabel.frame.size.width,
            y: 0, width: 200, height: contentView.frame.size.height)
    }
    
    func configure(with viewModel: DogeTableCellTableViewCellViewModel) {
        label.text = viewModel.title
        valuelabel.text = viewModel.value
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
