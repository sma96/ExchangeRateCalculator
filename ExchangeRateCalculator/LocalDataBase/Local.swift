//
//  LocalDB.swift
//  ExchangeRateCalculator
//
//  Created by 마석우 on 1/20/24.
//

import Foundation

// 선택한 언어 저장 후 다시 앱 시작할 때 저장한 언어로 설정하기 위해 구현
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
