//
//  String+Extension.swift
//  CyCoin
//
//  Created by Terry Kuo on 2021/5/15.
//

import Foundation

extension String {
    
    func convertToDate() -> Date? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = .current
        return dateFormatter.date(from: self)
    }
    
    func convertToDisplayFormat() -> String {
        
        guard let date = self.convertToDate2() else {
            return "N/A"
        }
        
        return date.convertToMonthDayYear()
    }
    
    func convertToDate2() -> Date? {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = .withFractionalSeconds
        dateFormatter.timeZone = .current
        return dateFormatter.date(from: self)
        
    }
}

//2021-06-15T07:55:03+0000
//2013-12-15T00:00:00.000Z
