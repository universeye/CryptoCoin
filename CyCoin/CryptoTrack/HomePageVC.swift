//
//  HomePageVC.swift
//  CyCoin
//
//  Created by Terry Kuo on 2021/5/16.
//

import UIKit

class HomePageVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHomePageVC()
    }
    
    private func configureHomePageVC() {
        view.backgroundColor = .systemRed
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    

}
