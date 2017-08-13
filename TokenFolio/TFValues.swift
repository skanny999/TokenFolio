//
//  TFUserDefaults.swift
//  TokenFolio
//
//  Created by Riccardo Scanavacca on 19/07/2017.
//  Copyright © 2017 Riccardo Scanavacca. All rights reserved.
//

import Foundation
import UIKit

enum Currency : String {
    
    case Btc = "BTC"
    case Usd = "$"
    case Eur = "€"
    case Gbp = "£"
    
}



struct Value {
    
    static func decimalFormat(_ double : Double) -> String {
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        
        return numberFormatter.string(from: NSNumber(value:double))!
        
    }
    
    

    
    static func formattedTokenValue(_ token : Token) -> String {
        
//        let value = tokenTotalValue(token)
        
        return formattedValue2Dec(token.totalValue!.doubleValue)
        
    }
    
    
    
    
    static func formattedValue2Dec(_ value : Double) -> String {
        
        let formattedNumber = decimalFormat(value)
        
        return String(format: "%@ %@", TFUserSettings.currentCurrency()!.rawValue, formattedNumber)
        
    }
    
    static func formattedValue6Dec(_ value : Double) -> String {
        
        let formattedNumber = String(format: "%.6f", locale: Locale.current, value)
        
        return String(format: "%@ %@", TFUserSettings.currentCurrency()!.rawValue, formattedNumber)
        
    }
    
    static func currencyIndex() -> Int {
        
        switch TFUserSettings.currentCurrency()! {
        case .Usd:
            return 0
        case .Eur:
            return 1
        case .Gbp:
            return 2
        default:
            return 0
        }
        
        
        
    }
    
    
    static func currencyCode() -> String {

        switch TFUserSettings.currentCurrency()! {
        case .Usd:
            return "USD"
        case .Eur:
            return "EUR"
        case .Gbp:
            return "GBP"
        default:
            return "USD"
        }
    }

}
