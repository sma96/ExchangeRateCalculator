//
//  ViewModel.swift
//  ExchangeRateCalculator
//
//  Created by 마석우 on 1/20/24.
//

import UIKit
import Combine

public class CurrencyViewModel {
    private var currencyModel: CurrencyModel = CurrencyModel()
    private var completion: ((Result<CurrencyResponse, NetworkError>) -> Void)?
    private var cancellables: Set<AnyCancellable> = Set()
    private var APIService: CurrencyAPIService = CurrencyAPIService()
}

//MARK: - textField subscribe 로직
extension CurrencyViewModel {
    // 참고 주소 - https://developer.apple.com/forums/thread/693602
    func textFieldBind(_ textField: UITextField, completion: @escaping (String) -> Void) {
        let textFieldPublisher = NotificationCenter.default.publisher(
            for: UITextField.textDidChangeNotification,
            object: textField
        )
        
        textFieldPublisher
            .compactMap { ($0.object as? UITextField)?.text }
            .sink {
                completion($0)
            }
            .store(in: &cancellables)
    }
}

//MARK: - getter 및 API 통신 로직
extension CurrencyViewModel {
    func getCurrency() -> CurrencyResponse? {
        return currencyModel.response
    }
    
    func getExchangeRate(type: CurrencyType) -> Double {
        switch type {
        case .KRW:
            return currencyModel.response?.quotes.krw ?? 0.0
        case .JPY:
            return currencyModel.response?.quotes.jpy ?? 0.0
        case .PHP:
            return currencyModel.response?.quotes.php ?? 0.0
        }
    }
    
    func getRequest() -> URLRequest? {
        var transaction = GetCurrencyDataTransaction()
        
        guard var urlComponents = URLComponents(string: transaction.url) else {
            return nil
        }
        
        transaction.addQuery("access_key", Secret.shared.apiKey)
        transaction.addQuery("source", "USD")
        transaction.addQuery("currencies", "KRW, JPY, PHP")
        
        urlComponents.queryItems = transaction.getQuery()
        
        var request = URLRequest(url: urlComponents.url!)
        
        request.httpMethod = "GET"
        request.timeoutInterval = 30
        
        return request
    }
    
    func getCurrencyData(completion: @escaping (Result<CurrencyResponse, NetworkError>) -> Void) {
        guard let request = getRequest() else {
            completion(.failure(.URLError))
            return
        }
            
        APIService.fetchData(request)
            .sink {
                switch $0 {
                case .failure(let error):
                    switch error {
                    case .DecodeError:
                        completion(.failure(.DecodeError))
                    case .URLError:
                        completion(.failure(.URLError))
                    default:
                        completion(.failure(.UnknownError))
                    }
                case .finished:
                    print("finished")
                }
            } receiveValue: { [weak self] response in
                self?.currencyModel.response = response
                completion(.success(response))
            }.store(in: &cancellables)
    }
}
