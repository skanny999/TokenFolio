//
//  TFStrings.swift
//  TokenFolio
//
//  Created by Riccardo Scanavacca on 20/07/2017.
//  Copyright © 2017 Riccardo Scanavacca. All rights reserved.
//

import Foundation

class TFFormatter {

    class func currencyFromNumber(_ number: NSNumber) -> String {
        
        let symbol : String
        
        switch TFUserSettings.currentCurrency()!{
        case .Usd:
            symbol = "$"
        case .Eur:
            symbol = "€"
        case .Gbp:
            symbol = "£"
        default:
            symbol = "$"
        }
        
        return String(format: "%@ %.2f", symbol, number.doubleValue)
        
    }
}


extension String  {
    
    var isNumber : Bool {
        get{
            return !self.isEmpty && self.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
        }
    }
}
