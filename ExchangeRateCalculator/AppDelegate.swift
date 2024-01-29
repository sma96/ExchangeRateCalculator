//
//  AppDelegate.swift
//  ExchangeRateCalculator
//
//  Created by 마석우 on 1/17/24.
//

import UIKit
import CryptoKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .white
        window?.rootViewController = MainViewController()
        
        return true
    }
}

