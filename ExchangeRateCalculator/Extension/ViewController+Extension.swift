//
//  ViewController+Extension.swift
//  ExchangeRateCalculator
//
//  Created by 마석우 on 1/22/24.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "확인", style: .cancel)
        
        alert.addAction(action)
        
        present(alert, animated: false)
    }
}
