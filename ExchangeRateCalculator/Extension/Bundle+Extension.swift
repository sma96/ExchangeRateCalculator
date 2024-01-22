//
//  Bundle+Extension.swift
//  ExchangeRateCalculator
//
//  Created by 마석우 on 1/22/24.
//

import Foundation

extension Bundle {
    var currencyAPIKey: String? {
        guard let file = self.path(forResource: "Info", ofType: "plist"),
              let resource = NSDictionary(contentsOfFile: file),
              let key = resource["CurrencyAPIKey"] as? String else {
            return nil
        }
        print("success api key")
        return key
    }
}
