//
//  TFCoreDataProvider.swift
//  TokenFolio
//
//  Created by Riccardo Scanavacca on 09/07/2017.
//  Copyright © 2017 Riccardo Scanavacca. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class TFCoreDataProvider {
    
    var managedObjectContext : NSManagedObjectContext
    var backgroundManagedObjectContext : NSManagedObjectContext
    
    static let shared: TFCoreDataProvider = {
        let instance = TFCoreDataProvider()
        
        return instance
    }()
    
    init() {
        
        managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        backgroundManagedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        backgroundManagedObjectContext.parent = managedObjectContext
        
    }
    
    func newToken() -> Token {
        
        return NSEntityDescription.insertNewObject(forEntityName: "Token", into: managedObjectContext) as! Token

    }
    
    func fetchAllTokens(completion: @escaping ([Token]) -> ()) {
        
        managedObjectContext.perform {
            
            let fetchRequest = NSFetchRequest<Token>(entityName: "Token")
        
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
            
            let results = try! fetchRequest.execute()
            
            completion (results)
            
        }
    }
    
    func fetchAllTokensBackground(completion: @escaping ([Token]) -> ()) {
        
        backgroundManagedObjectContext.perform {
            
            let fetchRequest = NSFetchRequest<Token>(entityName: "Token")
            
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
            
            let results = try! fetchRequest.execute()
            
            completion (results)
            
        }
    }
    
    
    
    func fetchTokensWithId( _ id : String, completion: @escaping ([Token]) ->()) {
        
        managedObjectContext.perform {
            
            let fetchRequest = NSFetchRequest<Token>(entityName: "Token")
            
            fetchRequest.predicate = NSPredicate(format: "id == %@", id)
            
            let tokens = try! fetchRequest.execute()
            
            completion (tokens)
            
        }
    }
    
    func fetchSelectedTokens(completion: @escaping([Token]) -> ()) {
        
        managedObjectContext.perform {
            
            let fetchRequest = self.selectedTokenFetchRequest()
            
            let tokens = try! fetchRequest.execute()
            
            completion(tokens)
        }
    }
    
    
    func tokensFetchRequest() -> NSFetchRequest<Token> {
        
        return NSFetchRequest<Token>(entityName: "Token")
        
    }
    
    
    func selectedTokensFetchResultController() -> NSFetchedResultsController<Token> {

        return NSFetchedResultsController<Token>(fetchRequest: selectedTokenFetchRequest(),
                                                 managedObjectContext: managedObjectContext,
                                                 sectionNameKeyPath: nil,
                                                 cacheName: nil)

    }
    
    
    func selectedTokenFetchRequest() -> NSFetchRequest<Token> {
        
        let request = NSFetchRequest<Token>(entityName: "Token")
        let predicate = NSPredicate(format: "isSelected == 1");
        request.predicate = predicate
        request.sortDescriptors = [NSSortDescriptor(key: "totalValue", ascending: false)]
        
        return request
        
    }
    
    
    
    
    func save() {
        
        do {
            
            try backgroundManagedObjectContext.save()
            
            managedObjectContext.perform {
                
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



    
    
    


