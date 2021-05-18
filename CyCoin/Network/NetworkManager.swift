//
//  NetworkManager.swift
//  CyCoin
//
//  Created by Terry Kuo on 2021/5/14.
//

import UIKit


final class NetworkManager {
    
    static let shared = NetworkManager()
    let cache = NSCache<NSString, UIImage>()
    public var imageURLViewModel: [String: String] = [:]
    
    private init () {
        
    }
    
    func getCurrency<T: Codable>(from endPoint: CurrencyAPI,
                     completion: @escaping (Result<T, APIError>) -> Void) {
        print("getting currency from: \(endPoint.urlRequest)")
        
        let task = URLSession.shared.dataTask(with: endPoint.urlRequest) { (data, response, error) in
            
            if let err = error {
                print("error2: \(err.localizedDescription)")
                completion(.failure(.unableToComplete))
                return
            }
            
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                print("error 3")
                completion(.failure(.invalidResponse))
                return
            }
            
            
            guard let data = data else {
                print("error4")
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                //decoder.keyDecodingStrategy = .convertFromSnakeCase
                //decoder.dateDecodingStrategy = .iso8601
                let currencys = try decoder.decode(T.self, from: data)
                completion(.success(currencys))
            } catch let decodingError {
                print("error 5")
                print(decodingError)
                completion(.failure(.failedToDecode))
            }
            
            
        }
        task.resume()
        
    }
    
    func getImageURL(completion: @escaping () -> Void) {
        getCurrency(from: .cryptoTrackerIcon) { [weak self] (results: Result<[CryptoIconResponse], APIError>) in
            
            guard let self = self else { return }
            switch results {
            
            case .success(let imageurls):
                for index in 0..<200 {
                    self.imageURLViewModel.updateValue(imageurls[index].url ?? "NA", forKey: imageurls[index].asset_id)
                }
                
                
                completion()
            case .failure(let error):
                print("Error fetching imageUrl: \(error.localizedDescription)")
            }
        }
    }
        
}
