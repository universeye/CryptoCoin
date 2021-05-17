//
//  APIEndPoint.swift
//  CyCoin
//
//  Created by Terry Kuo on 2021/5/14.
//

import Foundation

enum CurrencyAPI {
    case getDogeCoin
    case cryptoTracker
}


extension CurrencyAPI {
    var urlRequest: URLRequest {
        return URLRequest(url: URL(string: self.baseURL.appendingPathComponent(self.path).absoluteString.removingPercentEncoding!)!)
    }
    
    var baseURL: URL{
        switch self {
        case .getDogeCoin:
            return URL(string: "https://pro-api.coinmarketcap.com/v1/")!
            
        case .cryptoTracker:
            return URL(string: "https://rest.coinapi.io/v1/")!
        }
    }
    
    var path: String {
        switch self {
        case .getDogeCoin:
            return "cryptocurrency/quotes/latest" + "?" + "slug=dogecoin&CMC_PRO_API_KEY=" + SecretAPIKeys.coinMarketCap.rawValue
            
        case .cryptoTracker:
            return "assets/BTC;ETH;DOGE/?apikey=" + SecretAPIKeys.CoinAPIio.rawValue
        }
        
    }
}

