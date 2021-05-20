//
//  AlertScreenVC.swift
//  CyCoin
//
//  Created by Terry Kuo on 2021/5/17.
//

import UIKit

class AlertScreenVC: UIViewController {
    
    let alertImage = UIImageView(frame: .zero)
    let titleLabel = CyTrackerLabel(textSize: 30, textAlignment: .center, textColor: .black)
    let bodyLabel = CyTrackerLabel(textSize: 18, textAlignment: .center, textColor: .systemGray)
    let containerView = UIView()
    let okButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.layer.cornerRadius = 16
        button.setTitle("Ok", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = Colors.buttonColor
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
        configureContainerView()
        configureImage()
        configureLabel()
        configureButton()
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureContainerView() {
        containerView.backgroundColor = UIColor.white
        containerView.layer.cornerRadius = 16
        view.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 510),
            containerView.widthAnchor.constraint(equalToConstant: 340)
        ])
    }
    
    private func configureImage() {
        alertImage.image = UIImage(systemName: SFSymbols.alertImage)
        alertImage.contentMode = .scaleAspectFit
        alertImage.tintColor = .black
        containerView.addSubview(alertImage)
        alertImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            alertImage.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            alertImage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            alertImage.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            alertImage.heightAnchor.constraint(equalToConstant: 130)
        ])
    }
    
    private func configureLabel() {
        containerView.addSubview(titleLabel)
        titleLabel.text = "Something's Wrong!"
        titleLabel.minimumScaleFactor = 0.9
        
        containerView.addSubview(bodyLabel)
        bodyLabel.text = "Invalid response from the server, please try again later."
        bodyLabel.minimumScaleFactor = 0.7
        bodyLabel.numberOfLines = 3
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: alertImage.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            titleLabel.heightAnchor.constraint(equalToConstant: 50),
            
            bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            bodyLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            bodyLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            bodyLabel.heightAnchor.constraint(equalToConstant: 50)
        
        ])
        
    }
    
    private func configureButton() {
        okButton.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(okButton)
        okButton.addTarget(self, action: #selector(dismissAlertView), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            okButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20),
            okButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            okButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            okButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc func dismissAlertView() {
        dismiss(animated: true, completion: nil)
    }
    
}
