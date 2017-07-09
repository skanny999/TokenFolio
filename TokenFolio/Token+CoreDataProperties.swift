//
//  Token+CoreDataProperties.swift
//  TokenFolio
//
//  Created by Riccardo Scanavacca on 08/07/2017.
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
    @NSManaged public var marketCapEur: String?
    @NSManaged public var marketCapGbp: String?
    @NSManaged public var marketCapUsd: String?
    @NSManaged public var name: String?
    @NSManaged public var percentChange1h: String?
    @NSManaged public var percentChange7d: String?
    @NSManaged public var percentChange24h: String?
    @NSManaged public var priceBtc: String?
    @NSManaged public var priceEur: String?
    @NSManaged public var priceGbp: String?
    @NSManaged public var priceUsd: String?
    @NSManaged public var rank: Int16
    @NSManaged public var symbol: String?
    @NSManaged public var totalSupply: String?
    @NSManaged public var volume24hEur: String?
    @NSManaged public var volume24hGbp: String?
    @NSManaged public var volume24hUsd: String?

}
