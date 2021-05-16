//
//  CurrencyResponse.swift
//  CyCoin
//
//  Created by Terry Kuo on 2021/5/14.
//

import Foundation

struct CurrencyResponse: Codable {
    let status: Status
    let data: Datas
    
    enum CodingKeys: String, CodingKey {
        case status
        case data
    }
}

struct Status: Codable {
    let timestamp: String
}



struct Datas: Codable {
    let _74: _74
    
    enum CodingKeys: String, CodingKey {
        case _74 = "74"
    }
}

struct _74: Codable {
    let id: Int
    let name: String
    let symbol: String
    let date_added: String
    let tags: [String]
    let total_supply: Float
    let quote: [String: Quote]
    
}

struct Quote: Codable {
    let price: Float
    let volume_24h: Float
}
