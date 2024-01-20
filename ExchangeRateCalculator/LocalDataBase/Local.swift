//
//  LocalDB.swift
//  ExchangeRateCalculator
//
//  Created by 마석우 on 1/20/24.
//

import Foundation

struct Local {
    static var DB = Local()
    
    var currencyTag: Int {
        get {
            return (UserDefaults.standard.object(forKey: "Tag") as? Int) ?? 0
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "Tag")
        }
    }
}
