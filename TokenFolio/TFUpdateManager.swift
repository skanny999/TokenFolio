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
    
    var managedObjectContext : NSManagedObjectContext
    var backgroundManagedObjectContext : NSManagedObjectContext
    
    var jsonIDs = [String]()
    
    init() {
        
        managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        backgroundManagedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        backgroundManagedObjectContext.parent = managedObjectContext
        
    }
    
    
    
    func parseJON (json: Data) {
        
        let json = try? JSONSerialization.jsonObject(with: json, options: [])
        
        if let jsonArray =  json as? [Any] {
            
            backgroundManagedObjectContext.perform {
                
                for dict in jsonArray {
                    
                    self.updateTokensWithDictionaryInManagedObjectContext(dict as! [String : Any], self.backgroundManagedObjectContext)
                }
                
                self.deleteMissingTokensInManagedObjectContext(in: self.backgroundManagedObjectContext)

                self.save()
            }
        }
    }
    
    
    
    func updateTokensWithDictionaryInManagedObjectContext (_ dict : [String : Any], _ mod : NSManagedObjectContext) {
        
        let id = dict["id"]
        var results = [Token]()
        jsonIDs.append(id as! String)
        
        let fetchRequest = NSFetchRequest<Token>(entityName: "Token")
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as! String)

        results = try! fetchRequest.execute()
        
        if results.count > 0 {
            
            if let token = results.first {
                
                token.assignValuesToTokenFromDictionary(dict)
            }
            
        } else {
            
            Token.newTokenFromDictionaryInManagedObjectContext(dict, self.backgroundManagedObjectContext)
        }
    }
    
    
    
    func deleteMissingTokensInManagedObjectContext(in mod : NSManagedObjectContext) {
        
        let fetchRequest = NSFetchRequest<Token>(entityName: "Token")
        
        mod.perform {
            
            let tokens = try! fetchRequest.execute()
            
            for token in tokens {
                
                if !self.jsonIDs.contains(token.id!) {
                    
                    token.deleteInManagedObjectContext(mod)
                }
            }
            
            self.save()
        }
    }
    
    
    func save() {
        
        do {
            
            try self.backgroundManagedObjectContext.save()
            
            self.managedObjectContext.perform {
                
                do {
                    try self.managedObjectContext.save()
                    
                } catch {
                    
                    fatalError("Failure to save context: \(error)")
                }
            }
        } catch {
            
            fatalError("Failure to save context: \(error)")
        }
    }
    
    
    
}




















