//
//  ViewModel.swift
//  ExchangeRateCalculator
//
//  Created by 마석우 on 1/20/24.
//

import Foundation

public class CurrencyManager {
    private var currency: DataModel = DataModel()
    private var completion: ((Result<CurrencyResponse, NetworkError>) -> Void)?

    func getCurrency() -> CurrencyResponse? {
        return currency.response
    }
}

extension CurrencyManager {
    func getExchangeRate(type: CurrencyType) -> Double {
        switch type {
        case .KRW:
            return currency.response?.quotes.krw ?? 0.0
        case .JPY:
            return currency.response?.quotes.jpy ?? 0.0
        case .PHP:
            return currency.response?.quotes.php ?? 0.0
        }
    }
    
    func getCurrencyData(completion: @escaping (Result<CurrencyResponse, NetworkError>) -> Void) {
        var transaction = GetCurrencyDataTransaction()
        
        guard var urlComponents = URLComponents(string: transaction.url) else {
            completion(.failure(.URLError))
            return
        }
        self.completion = completion
        
        transaction.addQuery("access_key", GetCurrencyDataTransaction.apiKey)
        transaction.addQuery("source", "USD")
        transaction.addQuery("currencies", "KRW, JPY, PHP")
    
        urlComponents.queryItems = transaction.getQuery()
        
        var request = URLRequest(url: urlComponents.url!)
        
        request.httpMethod = "GET"
        request.timeoutInterval = 30
        
        fetchData(request)
    }
    
    private func fetchData(_ request: URLRequest) {
        URLSession.shared.dataTask(with: request) {[weak self] data, response, error in
            guard error == nil else {
                self?.completion!(.failure(.UnknownError))
                return
            }
            guard let res = response as? HTTPURLResponse, (200...300) ~= res.statusCode else {
                self?.completion!(.failure(.ResponseError))
                return
            }
            guard let safeData = data else {
                self?.completion!(.failure(.DataError))
                return
            }
            self?.decodeData(safeData)
        }.resume()
    }
    
    private func decodeData(_ data: Data) {
        let decoder = JSONDecoder()
        
        decoder.keyDecodingStrategy = .convertFromSnakeCase
            
        if let decodedData = try? decoder.decode(CurrencyResponse.self, from: data) {
            currency.response = decodedData
            
            self.completion!(.success(decodedData))
            
            return
        }
        self.completion!(.failure(.DecodeError))
    }
}
