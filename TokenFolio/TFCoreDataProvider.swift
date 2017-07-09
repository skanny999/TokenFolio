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
    
    init(_ mod : NSManagedObjectContext,  bmod : NSManagedObjectContext) {
        
        managedObjectContext = mod
        backgroundManagedObjectContext = bmod
        
        
    }
    

    
    
    
    

}
