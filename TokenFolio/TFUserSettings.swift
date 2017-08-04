//
//  TFUserDefaults.swift
//  TokenFolio
//
//  Created by Riccardo Scanavacca on 19/07/2017.
//  Copyright © 2017 Riccardo Scanavacca. All rights reserved.
//

import UIKit

class TFUserSettings {
    
    static func setCurrentCurrency(_ currency: Currency) {
        
        let rawCurrency = currency.rawValue;
        let userDefaults = UserDefaults.standard
        userDefaults.set(rawCurrency, forKey:"currency")
    }
    
    
    static func currentCurrency() -> Currency? {
        
        let userDefaults = UserDefaults.standard
        if let currencyRawValue  = userDefaults.string(forKey:"currency") {
            
            if let currency = Currency(rawValue: currencyRawValue) {
                
                return currency
            }
            else {
                
                setCurrentCurrency(Currency.Usd)
                return Currency.Usd
            }
        }
        else {
            
            setCurrentCurrency(Currency.Usd)
            return Currency.Usd
        }
    }
    
    
    static func setInitialInvestment(_ amount:Double) {
        
        let userDefaults = UserDefaults.standard
        userDefaults.set(amount, forKey: "investment")
    }
    
    
    static func initialInvestment() -> Double {
        
        let userDefaults = UserDefaults.standard
        let investment = userDefaults.double(forKey: "investment")

         return investment
        
    }
    
        
    
    
    

}
