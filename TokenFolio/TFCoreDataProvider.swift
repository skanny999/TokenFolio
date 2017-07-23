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
        
        return NSEntityDescription.insertNewObject(forEntityName: "Token", into: backgroundManagedObjectContext) as! Token

    }
    
    func fetchAllTokens(completion: @escaping ([Token]) -> ()) {
        
        backgroundManagedObjectContext.perform {
            
            let fetchRequest = NSFetchRequest<Token>(entityName: "Token")
        
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
            
            let results = try! fetchRequest.execute()
            
            completion (results)
            
        }
    }
    
    func fetchTokensWithId( _ id : String, completion: @escaping ([Token]) ->()) {
        
        backgroundManagedObjectContext.perform {
            
            let fetchRequest = NSFetchRequest<Token>(entityName: "Token")
            
            fetchRequest.predicate = NSPredicate(format: "id == %@", id)
            
            let results = try! fetchRequest.execute()
            
            completion (results)
            
        }
    }
    
    func tokensFetchRequest() -> NSFetchRequest<Token> {
        
        return NSFetchRequest<Token>(entityName: "Token")
        
    }
    
    
    func selectedTokensFetchResultController() -> NSFetchedResultsController<Token> {
        
        let request = NSFetchRequest<Token>(entityName: "Token")
        let predicate = NSPredicate(format: "isSelected == 1");
        let sortDescriptor = NSSortDescriptor(key: "totalValueBtc", ascending: true)
        request.predicate = predicate
        request.sortDescriptors = [sortDescriptor]
        
        return NSFetchedResultsController<Token>(fetchRequest: request,
                                                 managedObjectContext: managedObjectContext,
                                                 sectionNameKeyPath: nil,
                                                 cacheName: nil)

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



    
    
    


