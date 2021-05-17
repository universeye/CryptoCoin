//
//  CryptoResponse.swift
//  CyCoin
//
//  Created by Terry Kuo on 2021/5/16.
//

import Foundation

struct CryptoResponse: Codable {
    let asset_id: String
    let name: String
    let price_usd: Float?
}
