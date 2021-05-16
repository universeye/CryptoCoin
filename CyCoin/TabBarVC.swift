//
//  TabBarVC.swift
//  CyCoin
//
//  Created by Terry Kuo on 2021/5/15.
//

import UIKit

class TabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        viewControllers = [createHomePageVC(), createDogeCoinVC()]
    }
    
    func createDogeCoinVC() -> UIViewController {
        let dogeCoinVC = ViewController()
        
        dogeCoinVC.tabBarItem.image = UIImage(systemName: "dollarsign.circle.fill")
        dogeCoinVC.title = "DogeCoin"
        return dogeCoinVC
    }
    
    func createHomePageVC() -> UINavigationController {
        
        let homePageVC = HomePageVC()
        
        homePageVC.title = "Crypto Tracker"
        homePageVC.tabBarItem.image = UIImage(systemName: "bitcoinsign.square.fill")
        return UINavigationController(rootViewController: homePageVC)
    }
}
