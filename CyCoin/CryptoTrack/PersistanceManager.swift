//
//  PersistanceManager.swift
//  CyCoin
//
//  Created by Terry Kuo on 2021/5/18.
//

import Foundation

struct PersistanceManager {
    static let shared = PersistanceManager()
    
    var cryptoCoinArray: [String] {
        return ["BTC","ETH"]
    }
}
