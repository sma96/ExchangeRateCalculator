//
//  DataModel.swift
//  ExchangeRateCalculator
//
//  Created by 마석우 on 1/20/24.
//

import Foundation

struct DataModel {
    var response: CurrencyResponse?
}

struct CurrencyResponse: Codable {
    let success: Bool
    let terms: String
    let privacy: String
    let timestamp: Int
    let source: String
    let quotes: Quotes
    
    struct Quotes: Codable {
        let krw: Double
        let jpy: Double
        let php: Double
        
        enum CodingKeys: String, CodingKey {
            case krw = "USDKRW"
            case jpy = "USDJPY"
            case php = "USDPHP"
        }
    }
}
