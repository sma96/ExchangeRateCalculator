//
//  String+Extension.swift
//  ExchangeRateCalculator
//
//  Created by 마석우 on 1/21/24.
//

import Foundation

extension Double {
    var toCurrency: String {
        let formatter = NumberFormatter()
        
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        formatter.currencySymbol = ""
        let myNotification = Notification.Name("MyNotification")

        // 2
        let publisher = NotificationCenter.default
            .publisher(for: myNotification, object: nil)
        return formatter.string(from: NSNumber(value: self)) ?? "00"
    }
}
