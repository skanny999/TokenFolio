//
//  Token+CoreDataClass.swift
//  TokenFolio
//
//  Created by Riccardo Scanavacca on 24/06/2017.
//  Copyright © 2017 Riccardo Scanavacca. All rights reserved.
//

import Foundation
import UIKit
import CoreData


public class Token: NSManagedObject {

    struct keys {
        
        let availableSupply = "available_supply"
        let id =  "id"
        let lastUpdated = "last_updated"
        let marketCapEur = "market_cap_eur"
        let marketCapGbp = "market_cap_gbp"
        let marketCapUsd = "market_cap_usd"
        let name = "name"
        let percentChange1h = "percent_change_1h"
        let percentChange24h = "percent_change_24h"
        let percentChange7d = "percent_change_7d"
        let priceBtc = "price_btc"
        let priceEur = "price_eur"
        let priceGbp = "price_gbp"
        let priceUsd = "price_usd"
        let rank = "rank"
        let symbol = "symbol"
        let totalSupply = "total_supply"
        let volume24hEur = "24h_volume_eur"
        let volume24hGbp = "24h_volume_gbp"
        let volume24hUsd = "24h_volume_usd"
        
    }
    

    
    class func newTokenFromDictionary(_ dict : [String : Any]) {
        
        
        
        let token = TFCoreDataProvider.shared.newToken()
        
        token.assignValuesToTokenFromDictionary(dict)
  
    }
    
    
    
    func assignValuesToTokenFromDictionary(_ dict : [String : Any]) {
        
        let key = keys()
        
        if let availableSupply = dict[key.availableSupply] as? String {
            
            self.availableSupply = availableSupply
        }
        
        if let id = dict[key.id] as? String  {
            
            self.id = id
        }
        
        if let lastUpdated = dict[key.lastUpdated] as? String  {
            
            let seconds = Double(lastUpdated)
            self.lastUpdated = NSDate(timeIntervalSince1970:seconds!)
        }
        
        if let marketCapEur = dict[key.marketCapEur] as? String  {
            
            self.marketCapEur = marketCapEur
            
        } else {
            
            self.marketCapEur = nil
        }
        
        if let marketCapGbp = dict[key.marketCapGbp] as? String  {
            
            self.marketCapGbp = marketCapGbp
            
        } else {
            
            self.marketCapGbp = nil
        }
        
        if let marketCapUsd = dict[key.marketCapUsd] as? String  {
            
            self.marketCapUsd = marketCapUsd
        }
        
        if let name = dict[key.name] as? String  {
            
            self.name = name
        }
        
        if let percentChange1h = dict[key.percentChange1h] as? String  {
            
            self.percentChange1h = percentChange1h
        }
        
        if let percentChange24h = dict[key.percentChange24h] as? String  {
            
            self.percentChange24h = percentChange24h
        }
        
        if let priceBtc = dict[key.priceBtc]  as? String {
            
            self.priceBtc = NSNumber(value: Double(priceBtc)!)
        }
        
        if let priceEur = dict[key.priceEur] as? String  {
            
            self.priceEur = NSNumber(value: Double(priceEur)!)
            
        } else {
            
            self.priceEur = nil
        }
        
        if let priceGbp = dict[key.priceGbp] as? String  {
            
            self.priceGbp = NSNumber(value: Double(priceGbp)!)
            
        } else {
            
            self.priceGbp = nil
        }
        
        if let priceUsd = dict[key.priceUsd] as? String {
            
            self.priceUsd = NSNumber(value: Double(priceUsd)!)
        }
        
        if let rank = dict[key.rank] as? String  {
            
            let rankInt = Int16(rank)
            self.rank = rankInt!
        }
        
        if let symbol = dict[key.symbol] as? String  {
            
            self.symbol = symbol
        }
        
        if let totalSupply = dict[key.totalSupply] as? String  {
            
            self.totalSupply = totalSupply
        }
        
        if let volume24hEur = dict[key.volume24hEur] as? String  {
            
            self.volume24hEur = volume24hEur
            
        } else {
            
            self.volume24hEur = nil
        }
        
        if let volume24hGbp = dict[key.volume24hGbp] as? String  {
            
            self.volume24hGbp = volume24hGbp
            
        } else {
            
            self.volume24hGbp = nil
        }
        
        if let volume24hUsd = dict[key.volume24hUsd] as? String  {
            
            self.volume24hUsd = volume24hUsd
        }
        
        if (quantity?.intValue)! > 0 {
            
            Value.setTotalValueForToken(self)
            
        }
        print(self)
    }
    
    


    public func delete() {
        
        TFCoreDataProvider.shared.backgroundManagedObjectContext.delete(self)
    }
    

}
