//
//  TFTokenTableViewCell.swift
//  TokenFolio
//
//  Created by Riccardo Scanavacca on 15/07/2017.
//  Copyright © 2017 Riccardo Scanavacca. All rights reserved.
//

import UIKit

class TFTokenTableViewCell: UITableViewCell {

    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var variationTimeLabel: UILabel!
    @IBOutlet weak var variationLabel: UILabel!
    
    
    @IBOutlet weak var totalValueLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    func configureCellWithToken(_ token: Token) {
        
        symbolLabel.text = token.symbol
        nameLabel.text = token.name
        quantityLabel.text = String(format: "Qty: %@", (token.quantity?.intValue)!)
        variationLabel.text = token.percentChange24h
        variationTimeLabel.text = "24h"
        
        switch TFUserSettings.currentCurrency()! {
        case .Usd:
            priceLabel.text = TFFormatter.currencyFromNumber(token.priceUsd!)
            totalValueLabel.text = token.totalValueUsd!
        case .Eur:
            priceLabel.text = TFFormatter.currencyFromNumber(token.priceUsd!)
            totalValueLabel.text = token.totalValueEur!
        case .Gbp:
            priceLabel.text = TFFormatter.currencyFromNumber(token.priceUsd!)
            totalValueLabel.text = token.totalValueGbp!
        default:
            priceLabel.text = "N/A"
            totalValueLabel.text = "N/A"
        }
        
        
    }
    

}
