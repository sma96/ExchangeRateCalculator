//
//  NetworkError+Enum.swift
//  ExchangeRateCalculator
//
//  Created by 마석우 on 1/20/24.
//

import Foundation

enum NetworkError: Error {
    case ResponseError
    case TimeoutError
    case DecodeError
    case URLError
    case DataError
    case UnknownError
}
