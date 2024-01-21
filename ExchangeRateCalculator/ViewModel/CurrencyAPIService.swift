//
//  CurrencyAPIService.swift
//  ExchangeRateCalculator
//
//  Created by 마석우 on 1/21/24.
//

import UIKit
import Combine

class CurrencyAPIService {
    public func fetchData(_ request: URLRequest) -> AnyPublisher<CurrencyResponse, Error> {
        let decoder = JSONDecoder()
        
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: CurrencyResponse.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
}
