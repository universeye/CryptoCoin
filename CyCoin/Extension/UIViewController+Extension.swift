//
//  UIViewController+Extension.swift
//  CyCoin
//
//  Created by Terry Kuo on 2021/5/16.
//

import UIKit

fileprivate var containerView: UIView!

extension UIViewController {
    
    func presentAlertView() {
        DispatchQueue.main.async {
            let alertView = AlertScreenVC()
            alertView.modalTransitionStyle = .crossDissolve
            self.present(alertView, animated: true, completion: nil)
        }
    }
    
    func showLoadingView() {
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        
        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0
        
        //animate containerView alpha from 0 to 0.8
        UIView.animate(withDuration: 0.25) {
            containerView.alpha = 0.8
        }
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)
        containerView.bringSubviewToFront(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ])
        
        activityIndicator.startAnimating()
    }
    
    func dimissLoadingView() {
        DispatchQueue.main.async {
            containerView.removeFromSuperview()
            containerView = nil
        }
        
    }
}
