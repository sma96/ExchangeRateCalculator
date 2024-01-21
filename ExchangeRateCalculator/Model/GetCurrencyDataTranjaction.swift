//
//  GetCurrencyDataTranjaction.swift
//  ExchangeRateCalculator
//
//  Created by 마석우 on 1/20/24.
//

import Foundation

struct GetCurrencyDataTransaction {
    static let apiKey = "c93c20968ed6f9adfe0cfd65341593c7"
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
