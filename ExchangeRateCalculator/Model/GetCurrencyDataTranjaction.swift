//
//  GetCurrencyDataTranjaction.swift
//  ExchangeRateCalculator
//
//  Created by 마석우 on 1/20/24.
//

import Foundation

struct GetCurrencyDataTransaction {
    let url: String = "http://api.currencylayer.com/live"
    private var queries: [URLQueryItem] = [URLQueryItem]()
    
    func getURL() -> String {
        return url
    }
    
    func getQuery() -> [URLQueryItem] {
        return queries
    }
    
    mutating func addQuery(_ key: String, _ value: String) {
        queries.append(URLQueryItem(name: key, value: value))
    }
}
