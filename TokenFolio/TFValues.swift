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
    
    case Btc = "btc"
    case Usd = "usd"
    case Eur = "eur"
    case Gbp = "gbp"
    
}

struct Value {
    
    static func setTotalValueForToken(_ token: Token) {
        
        let quantity = (token.quantity?.doubleValue)!

        switch TFUserSettings.currentCurrency()! {
        case .Usd:
            let price = (token.priceUsd?.doubleValue)!
            token.totalValueUsd = NSNumber(value: quantity * price)
        case .Eur:
          token.totalValueUsd = NSNumber(value: quantity * (token.priceEur?.doubleValue)!)
        case .Gbp:
            token.totalValueUsd = NSNumber(value: quantity * (token.priceGbp?.doubleValue)!)
        default:
            token.totalValueUsd = NSNumber(value: quantity * (token.priceUsd?.doubleValue)!)
        }
        
        
    }
    
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
        
        let formattedNumber = String(format: "%.2f", locale: Locale.current, Double(price))

        return String(format: "%@%@", currencySymbol(token), formattedNumber)

    }

    
    static func formattedTotalValue(_ token : Token) -> String {
        
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
        
        let formattedNumber = String(format: "%.2f", locale: Locale.current, Double(value))
        
        return String(format: "%@ %@", currencySymbol(token), formattedNumber)

    }
    
    
    static func currencySymbol(_ token: Token) -> String {
        
        switch TFUserSettings.currentCurrency()! {
        case .Usd:
            return "$"
        case .Eur:
            return "€"
        case .Gbp:
            return "£"
        default:
            return "$"
        }
    }
    
  
 
}
