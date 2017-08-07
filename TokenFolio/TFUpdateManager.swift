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
    
    static func updateTokens() {
        
        TFNetworkProvider.fetchJSON()
        
    }
    
    
    var jsonIDs = [String]()
 
    func parseJON (json: Data) {
        
        let json = try? JSONSerialization.jsonObject(with: json, options: [])
        
        if let jsonArray =  json as? [Any] {
            
            TFCoreDataProvider.shared.backgroundManagedObjectContext.perform {
                
                for dict in jsonArray {
                    
                    self.updateTokenWithDictionary(dict as! [String : Any])
                }
                
                self.deleteMissingTokens()
                
                TFCoreDataProvider.shared.save()
                print("Saved")
            }
        }
    }
    
    
    
    func updateTokenWithDictionary(_ dict : [String : Any]) {
        
        let id = dict["id"] as! String

        jsonIDs.append(id)

        TFCoreDataProvider.shared.fetchTokensWithId(id) { (results) in
            
            if results.count > 0 {
                
                if let token = results.first {
                    
                    token.assignValuesToTokenFromDictionary(dict)
                    
                    if token.isSelected == true {
                        
                        print(token)
                    }
                    
                }
                
            } else {
                
                Token.newTokenFromDictionary(dict)
            }
            

        }
    }

    
    func deleteMissingTokens() {
        
        TFCoreDataProvider.shared.fetchAllTokensBackground { (tokens) in
            
            if tokens.count > 0 {
                
                for token in tokens {
                    
                    if let tokenId = token.id {
                        
                        if !self.jsonIDs.contains(tokenId) {
                            
                            token.delete()
                        }
                        
                    } else {
                        
                        token.delete()
                    }
                }
            }
        }
    }
    
}




















