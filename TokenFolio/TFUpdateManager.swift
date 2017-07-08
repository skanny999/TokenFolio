//
//  UpdateManager.swift
//  TokenFolio
//
//  Created by Riccardo Scanavacca on 24/06/2017.
//  Copyright © 2017 Riccardo Scanavacca. All rights reserved.
//

import UIKit
import CoreData

class TFUpdateManager {
    
    let context : NSManagedObjectContext
    
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

    
    init () {
        
        context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
         print(context)
    }
    
    
    
    func parseJON (json: Data) {
        
        let json = try? JSONSerialization.jsonObject(with: json, options: [])
        
        if let jsonArray =  json as? [Any] {
            
            for dict in jsonArray {
                
                createToken(dict: dict as! [String : Any])
                
            }
            
            printTokens()
        }
    }
    
    func printTokens() {
    
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Token")
        
        do {
            let tokens = try context.fetch(fetchRequest) as! [Token]
            
            print(tokens)
            
        } catch {
            fatalError("Failed to fetch employees: \(error)")
        }
        

    
    }
    

    
    
    func createToken (dict : [String:Any]) {
        
        let key = keys()
        
        let token = Token(context: context)
        
        if let availableSupply = dict[key.availableSupply] as? String {
            
            token.availableSupply = availableSupply
        }
        
        if let id = dict[key.id] as? String  {
            
            token.id = id
        }
        
        if let lastUpdated = dict[key.lastUpdated] as? String  {
            
            token.lastUpdated = lastUpdated
            
        }
        
        if let marketCapEur = dict[key.marketCapEur] as? String  {
            
            token.marketCapEur = marketCapEur
            
        } else {
            
            token.marketCapEur = nil
        }

        
        if let marketCapGbp = dict[key.marketCapGbp] as? String  {
            
            token.marketCapGbp = marketCapGbp
            
        } else {
            
            token.marketCapGbp = nil
        }
        
        if let marketCapUsd = dict[key.marketCapUsd] as? String  {
            
            token.marketCapUsd = marketCapUsd
        }
        
        if let name = dict[key.name] as? String  {
            
            token.name = name
        }
        
        if let percentChange1h = dict[key.percentChange1h] as? String  {
            
            token.percentChange1h = percentChange1h
        }
        
        if let percentChange24h = dict[key.percentChange24h] as? String  {
            
            token.percentChange24h = percentChange24h
        }
        
        if let priceBtc = dict[key.priceBtc]  as? String {
            
            token.priceBtc = priceBtc
        }
        
        if let priceEur = dict[key.priceEur] as? String  {
            
            token.priceEur = priceEur
            
        } else {
            
            token.priceEur = nil
        }
        
        
        if let priceGbp = dict[key.priceGbp] as? String  {
            
            token.priceGbp = priceGbp
            
        } else {
            
            token.priceGbp = nil
        }
        
        if let priceUsd = dict[key.priceUsd] as? String {
            
            token.priceUsd = priceUsd
        }
        
        if let rank = dict[key.rank] as? String  {
            
            token.rank = rank
        }
        
        if let symbol = dict[key.symbol] as? String  {
            
            token.symbol = symbol
        }
        
        if let totalSupply = dict[key.totalSupply] as? String  {
            
            token.totalSupply = totalSupply
        }
        
        if let volume24hEur = dict[key.volume24hEur] as? String  {
            
            token.volume24hEur = volume24hEur
            
        } else {
            
            token.volume24hEur = nil
        }
        
        if let volume24hGbp = dict[key.volume24hGbp] as? String  {
            
            token.volume24hGbp = volume24hGbp
            
        } else {
            
            token.volume24hGbp = nil
        }
        
        if let volume24hUsd = dict[key.volume24hUsd] as? String  {
            
            token.volume24hUsd = volume24hUsd
        }
    }
  
}
