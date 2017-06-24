//
//  Token+CoreDataProperties.swift
//  TokenFolio
//
//  Created by Riccardo Scanavacca on 24/06/2017.
//  Copyright © 2017 Riccardo Scanavacca. All rights reserved.
//

import Foundation
import CoreData


extension Token {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Token> {
        return NSFetchRequest<Token>(entityName: "Token")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var symbol: String?
    @NSManaged public var rank: String?
    @NSManaged public var priceUsd: String?
    @NSManaged public var priceBtc: String?
    @NSManaged public var priceEur: String?
    @NSManaged public var priceGbp: String?
    @NSManaged public var volume24hUsd: String?
    @NSManaged public var volume24hGbp: String?
    @NSManaged public var volume24hEur: String?
    @NSManaged public var marketCapUsd: String?
    @NSManaged public var marketCapEur: String?
    @NSManaged public var marketCapGbp: String?
    @NSManaged public var availableSupply: String?
    @NSManaged public var totalSupply: String?
    @NSManaged public var percentChange1h: String?
    @NSManaged public var percentChange24h: String?
    @NSManaged public var percentChange7d: String?
    @NSManaged public var lastUpdated: String?
    @NSManaged public var isSelected: Bool

}
