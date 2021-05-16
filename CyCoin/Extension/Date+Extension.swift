//
//  Date+Extension.swift
//  CyCoin
//
//  Created by Terry Kuo on 2021/5/15.
//

import Foundation

extension Date {
    func convertToMonthDayYear() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        
        return dateFormatter.string(from: self)
    }
}
