//
//  Token+CoreDataProperties.swift
//  TokenFolio
//
//  Created by Riccardo Scanavacca on 11/08/2017.
//  Copyright © 2017 Riccardo Scanavacca. All rights reserved.
//

import Foundation
import CoreData


extension Token {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Token> {
        return NSFetchRequest<Token>(entityName: "Token")
    }

    @NSManaged public var availableSupply: String?
    @NSManaged public var id: String?
    @NSManaged public var isSelected: Bool
    @NSManaged public var lastUpdated: NSDate?
    @NSManaged public var name: String?
    @NSManaged public var percentChange1h: String?
    @NSManaged public var percentChange7d: String?
    @NSManaged public var percentChange24h: String?
    @NSManaged public var priceBtc: NSNumber?
    @NSManaged public var quantity: NSNumber?
    @NSManaged public var rank: Int16
    @NSManaged public var symbol: String?
    @NSManaged public var totalSupply: String?
    @NSManaged public var totalValue: NSNumber?
    @NSManaged public var totalValueBtc: NSNumber?
    @NSManaged public var marketCap: String?
    @NSManaged public var price: NSNumber?
    @NSManaged public var volume24h: String?
    @NSManaged public var user: User?

}
