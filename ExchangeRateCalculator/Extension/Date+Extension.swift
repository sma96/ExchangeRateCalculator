//
//  String+Extension.swift
//  ExchangeRateCalculator
//
//  Created by 마석우 on 1/21/24.
//

import Foundation

extension Date {
    var toString: String {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        return formatter.string(from: self)
    }
}
