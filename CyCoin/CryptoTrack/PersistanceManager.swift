//
//  PersistanceManager.swift
//  CyCoin
//
//  Created by Terry Kuo on 2021/5/18.
//

import Foundation

class PersistanceManager {
    static var shared = PersistanceManager()
    
    private let defaults = UserDefaults.standard
    
    enum Keys {
        static let cryptoCoin = "cryptoCoin"
    }
    
    var coinSet: Set<String> = ["BTC","ETH"]
    
    func saveTheSetArray() {
        let coinArray = Array(coinSet)
        defaults.setValue(coinArray, forKey: Keys.cryptoCoin)
    }
    
    func getTheSetArray() -> Set<String> {
        let coinarray = defaults.object(forKey: Keys.cryptoCoin) as? [String] ?? [String]()
        let coSet = Set(coinarray)
        return coSet
    }
}
