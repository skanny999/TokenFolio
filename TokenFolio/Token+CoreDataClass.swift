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
    
    static let backgroundManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.newBackgroundContext()
    
    
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
    

    
    class func newTokenFromDictionaryInManagedObjectContext(_ dict : [String : Any], _ mod : NSManagedObjectContext) {
        
        let token = NSEntityDescription.insertNewObject(forEntityName: "Token", into: mod) as! Token
        
        token.assignValuesToTokenFromDictionary(dict)
        
        
    }
    
    func assignValuesToTokenFromDictionary(_ dict : [String : Any]) {
        
        let key = keys()
        
        if let availableSupply = dict[key.availableSupply] as? String,
            let lastUpdated = dict[key.lastUpdated] as? String,
            let id = dict[key.id] as? String,
            let marketCapEur = dict[key.marketCapEur] as? String,
            let marketCapGbp = dict[key.marketCapGbp] as? String,
            let marketCapUsd = dict[key.marketCapUsd] as? String,
            let name = dict[key.name] as? String,
            let percentChange1h = dict[key.percentChange1h] as? String,
            let percentChange24h = dict[key.percentChange24h] as? String,
            let priceBtc = dict[key.priceBtc]  as? String,
            let priceEur = dict[key.priceEur] as? String,
            let priceGbp = dict[key.priceGbp] as? String,
            let priceUsd = dict[key.priceUsd] as? String,
            let rank = dict[key.rank] as? String,
            let symbol = dict[key.symbol] as? String,
            let totalSupply = dict[key.totalSupply] as? String,
            let volume24hEur = dict[key.volume24hEur] as? String,
            let volume24hGbp = dict[key.volume24hGbp] as? String,
            let volume24hUsd = dict[key.volume24hUsd] as? String
        
        {
            self.availableSupply = availableSupply
            self.id = id
            self.lastUpdated = NSDate(timeIntervalSince1970:Double(lastUpdated)!)
            self.marketCapEur = marketCapEur
            self.marketCapEur = marketCapEur
            self.marketCapGbp = marketCapGbp
            self.marketCapGbp = marketCapGbp
            self.marketCapUsd = marketCapUsd
            self.name = name
            self.percentChange1h = percentChange1h
            self.percentChange24h = percentChange24h
            self.priceBtc = priceBtc
            self.priceEur = priceEur
            self.priceEur = priceEur
            self.priceGbp = priceGbp
            self.priceGbp = priceBtc
            self.priceUsd = priceUsd
            self.rank = Int16(rank)!
            self.symbol = symbol
            self.totalSupply = totalSupply
            self.volume24hEur = volume24hEur
            self.volume24hEur = volume24hEur
            self.volume24hGbp = volume24hGbp
            self.volume24hGbp = volume24hGbp
            self.volume24hUsd = volume24hUsd
        }

    }
    
    
    

    

    public func deleteInManagedObjectContext(_ mod : NSManagedObjectContext) {
        
        mod.delete(self)
    }
    

}
