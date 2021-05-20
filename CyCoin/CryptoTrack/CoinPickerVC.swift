//
//  CoinPickerVC.swift
//  CyCoin
//
//  Created by Terry Kuo on 2021/5/19.
//

import UIKit

protocol CoinPickerVCDelegate {
    func didAddCoin()
}

class CoinPickerVC: UIViewController {

    //cancel Button DONE
    //Title Label DONE
    //alert label DONE
    //card shadow DONE
    //array no same items DONE
    
    //HomepageVC reload DONE
    //delete action DONE
    //core data save DONE
    //Launch animation
    //price title color based on last coin
    
    //MARK: - Properties
    private let titleLabel = CyTrackerLabel(textSize: 25, textAlignment: .left, textColor: .black)
    private let bodyLabel = CyTrackerLabel(textSize: 15, textAlignment: .left, textColor: .systemRed)
    private let coins: [String] = ["BTC", "ETH", "DOGE", "XRP", "NMC", "USDT", "LTC", "ZEC", "BCH", "MKR"]
    private var selectedCoin: String = ""
    private let pickerView = UIPickerView()
    private let containerView = UIView()
    
    var delegate: CoinPickerVCDelegate!
    private let okButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.layer.cornerRadius = 16
        button.setTitle("Add", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = Colors.buttonColor
        return button
    }()
    
    private let cancelButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return button
    }()
    
    //MARK: - Apps Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        configureContainerView()
        configrueLabel()
        configureButton()
        
        configureBodyLabel()
        configurePicker()
    }
    
    //MARK: - Initializers
    init() {
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - UI Configuration
    private func configureContainerView() {
        containerView.backgroundColor = UIColor.white
        containerView.layer.cornerRadius = 16
        view.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        //containerView.layer.borderWidth = 1
        //containerView.layer.borderColor = UIColor.black.cgColor
        
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOffset = .zero
        containerView.layer.shadowRadius = 20
        containerView.layer.shadowOpacity = 0.6
        
        
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 510),
            containerView.widthAnchor.constraint(equalToConstant: 340)
        ])
    }
    
    private func configrueLabel() {
        containerView.addSubview(titleLabel)
        titleLabel.text = "Add a coin!"
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            titleLabel.widthAnchor.constraint(equalToConstant: 200),
            titleLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func configureBodyLabel() {
        containerView.addSubview(bodyLabel)
        bodyLabel.text = "" //please select a coin!
        bodyLabel.font = UIFont.systemFont(ofSize: 15, weight: .light)
        
        NSLayoutConstraint.activate([
            bodyLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            bodyLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            bodyLabel.heightAnchor.constraint(equalToConstant: 50),
            bodyLabel.bottomAnchor.constraint(equalTo: okButton.topAnchor, constant: -40)
        ])
    }
    
    private func configurePicker() {
        containerView.addSubview(pickerView)
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.setValue(Colors.pickerColor, forKeyPath: "textColor")
        
        NSLayoutConstraint.activate([
            pickerView.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 80),
            pickerView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            pickerView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            pickerView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }

   
    
    private func configureButton() {
        okButton.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(okButton)
        okButton.addTarget(self, action: #selector(addButtonPressed), for: .touchUpInside)
        
        containerView.addSubview(cancelButton)
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        
        
        NSLayoutConstraint.activate([
            okButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20),
            okButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            okButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            okButton.heightAnchor.constraint(equalToConstant: 50),
            
            
            cancelButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            cancelButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            cancelButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            cancelButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    //MARK: - Functional
    @objc func addButtonPressed() {
        if !selectedCoin.isEmpty {
            PersistanceManager.shared.coinSet.insert(selectedCoin)
            PersistanceManager.shared.saveTheSetArray()
            dismiss(animated: true, completion: nil)
            delegate.didAddCoin()
        } else {
            bodyLabel.text = "please select a coin!"
        }
    }
    
    @objc func cancelButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
     
}



//MARK: - UIPicker Extension
extension CoinPickerVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coins.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coins[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCoin = coins[row]
        
    }
}
