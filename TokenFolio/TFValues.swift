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
    
//    static func setTotalValueForToken(_ token: Token) {
//        
//        let quantity = (token.quantity?.doubleValue)!
//
//        switch TFUserSettings.currentCurrency()! {
//        case .Usd:
//            token.totalValueUsd = NSNumber(value: quantity * (token.priceUsd?.doubleValue)!)
//        case .Eur:
//          token.totalValueUsd = NSNumber(value: quantity * (token.priceEur?.doubleValue)!)
//        case .Gbp:
//            token.totalValueUsd = NSNumber(value: quantity * (token.priceGbp?.doubleValue)!)
//        default:
//            token.totalValueUsd = NSNumber(value: quantity * (token.priceUsd?.doubleValue)!)
//        }
    
        
        
    
    
    static func formattedTokenPrice(_ token:Token) -> String {
    
        let price : Double
        
        switch TFUserSettings.currentCurrency()! {
        case .Usd:
            price = token.priceUsd!.doubleValue
        case .Eur:
            price = token.priceEur!.doubleValue
        case .Gbp:
            price = token.priceGbp!.doubleValue
        default:
            price = token.priceUsd!.doubleValue
        }

        return formattedValue(price)

    }

    
    static func formattedTokenValue(_ token : Token) -> String {
        
        let value = tokenTotalValue(token)
        
        return formattedValue(value)
        
    }
    
    static func tokenTotalValue(_ token : Token) -> Double {
        
        let value : Double
        
        switch TFUserSettings.currentCurrency()! {
        case .Usd:
            value = token.totalValueUsd!.doubleValue
        case .Eur:
            value = token.totalValueEur!.doubleValue
        case .Gbp:
            value = token.totalValueGbp!.doubleValue
        default:
            value = token.totalValueUsd!.doubleValue
        }
        
        return value
        
    }
    
    
    
    static func formattedValue(_ value : Double) -> String {
        
        let formattedNumber = String(format: "%.2f", locale: Locale.current, value)
        
        return String(format: "%@ %@", TFUserSettings.currentCurrency()!.rawValue, formattedNumber)
        
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
