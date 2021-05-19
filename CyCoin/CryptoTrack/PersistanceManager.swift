//
//  PersistanceManager.swift
//  CyCoin
//
//  Created by Terry Kuo on 2021/5/18.
//

import Foundation

struct PersistanceManager {
    static var shared = PersistanceManager()
    
    var cryptoCoinArray: Set<String> =  ["BTC","ETH"]
}
