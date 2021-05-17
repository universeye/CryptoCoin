//
//  CryptoIconResponse.swift
//  CyCoin
//
//  Created by Terry Kuo on 2021/5/17.
//

import Foundation

struct CryptoIconResponse: Codable{
    let asset_id: String
    let url: String?
}


// ["BTC","XRP","NMC","USDT","DOGE","ETH"]
// let aee = ["DOGE": "https://s3.eu-central-1.amazonaws.com/bbxt-static-icons/type-id/png_512/63e240f3047f41c791796784bc719f63.png",
//            "BTC": "https://s3.eu-central-1.amazonaws.com/bbxt-static-icons/type-id/png_512/4caf2b16a0174e26a3482cea69c34cba.png",
//            "SGD": "https://s3.eu-central-1.amazonaws.com/bbxt-static-icons/type-id/png_512/d56573126b3945d6b0e2340459c1fda1.png",
//            "XRP": "https://s3.eu-central-1.amazonaws.com/bbxt-static-icons/type-id/png_512/ba90bcb0cafb4801ac5dd310f47d6411.png",
//            "EUR": "https://s3.eu-central-1.amazonaws.com/bbxt-static-icons/type-id/png_512/688fcf1c92bb4c84ac950971e9bfed2f.png",
//            "RUB": "https://s3.eu-central-1.amazonaws.com/bbxt-static-icons/type-id/png_512/929f34c014dd4a9b90967988671199b2.png",
//            "CAD": "https://s3.eu-central-1.amazonaws.com/bbxt-static-icons/type-id/png_512/2ba6caaf33b9496e8a39dd96a1b1bbe1.png",
//            "SLL": "https://s3.eu-central-1.amazonaws.com/bbxt-static-icons/type-id/png_512/c16f5692239842d091c6e503878f327a.png",
//            "NMC": "https://s3.eu-central-1.amazonaws.com/bbxt-static-icons/type-id/png_512/806538b8257e4a34b5ca749546a74512.png",
//            "BLC": "https://s3.eu-central-1.amazonaws.com/bbxt-static-icons/type-id/png_512/81dfc73a2b2c43f88d4eb628d10fdafb.png",
//            "USD": "https://s3.eu-central-1.amazonaws.com/bbxt-static-icons/type-id/png_512/0a4185f21a034a7cb866ba7076d8c73b.png",
//            "PLN": "https://s3.eu-central-1.amazonaws.com/bbxt-static-icons/type-id/png_512/3f682b5b77ec4d8cb612b8ff3ac748f7.png",
//            "AUD": "https://s3.eu-central-1.amazonaws.com/bbxt-static-icons/type-id/png_512/c33d154f14df49b6b7346c4f3034e548.png",
//            "KRW": "https://s3.eu-central-1.amazonaws.com/bbxt-static-icons/type-id/png_512/d264bc64760547998239c9b9b38f1beb.png",
//            "GBP": "https://s3.eu-central-1.amazonaws.com/bbxt-static-icons/type-id/png_512/6113eae75525442485b593d9e42d18f6.png",
//            "VEN": "https://s3.eu-central-1.amazonaws.com/bbxt-static-icons/type-id/png_512/99d66a679bdc4b8584ac2a23f912b398.png",
//            "NVC": "https://s3.eu-central-1.amazonaws.com/bbxt-static-icons/type-id/png_512/a7462768a4ba40e9b1ca73120b8bf7b4.png",
//            "USDT": "https://s3.eu-central-1.amazonaws.com/bbxt-static-icons/type-id/png_512/5ed65416963e4e57998a3c302da8936e.png",
//            "LTC": "https://s3.eu-central-1.amazonaws.com/bbxt-static-icons/type-id/png_512/a201762f149941ef9b84e0742cd00e48.png",
//            "DKK": "https://s3.eu-central-1.amazonaws.com/bbxt-static-icons/type-id/png_512/d94acf362346462fb776445a984882b8.png"]
