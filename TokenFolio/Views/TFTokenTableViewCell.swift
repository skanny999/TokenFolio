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
        quantityLabel.text = "Qty: \((token.quantity?.intValue)!)"
        
        let percentChange = Double(token.percentChange24h!)!
        
        if percentChange > 0.0 {
            
            
        } else {
            
            
        }

        variationLabel.text = token.percentChange24h
        variationTimeLabel.text = "24h"
        
        priceLabel.text = Value.formattedTokenPrice(token)
        totalValueLabel.text = Value.formattedTotalValue(token)

    }
    

}
