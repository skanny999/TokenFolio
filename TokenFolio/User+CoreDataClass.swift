//
//  User+CoreDataClass.swift
//  TokenFolio
//
//  Created by Riccardo Scanavacca on 15/07/2017.
//  Copyright © 2017 Riccardo Scanavacca. All rights reserved.
//

import Foundation
import CoreData

@objc(User)

public class User: NSManagedObject {
    
    class func newUserInManagedObjectContext(_ mod : NSManagedObjectContext) {
        
        let user = NSEntityDescription.insertNewObject(forEntityName: "User", into: mod) as! User
        user.currency = "USD"
        
        
        do {
            try mod.save()
        }
        catch {
            fatalError("Failure to save context: \(error)")
        }
        
        
    }

}
