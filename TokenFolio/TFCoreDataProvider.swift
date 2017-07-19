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
    
    init() {
        
        managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        backgroundManagedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        backgroundManagedObjectContext.parent = managedObjectContext
        
    }
    
    func fetchAllTokens(completion: @escaping ([Token]) -> ()) {
        
        managedObjectContext.perform {
        
        let fetchRequest = NSFetchRequest<Token>(entityName: "Token")
        
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
            
            let results = try! fetchRequest.execute()
            
            completion (results)
            
        } 
        
    }
    
}



    
    
    


