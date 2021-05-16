//
//  APIError.swift
//  CyCoin
//
//  Created by Terry Kuo on 2021/5/14.
//

import Foundation

enum APIError: String, Error{
    case invalidUserName = "This username created an Invalid request."
    case unableToComplete = "Unable to complete your requst, please try again later."
    case invalidResponse = "Invalid response from the server , please check the username."
    case invalidData = "The data from the server recieved was invalid."
    case failedToDecode = "Decoding Falied."
    case unableToFavorites = "There was an error retrieving favorites"
    case alreadyInFav = "You've already add this user in your favorites"
}
