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
        quantityLabel.text = "Qty: \((token.quantity?.doubleValue)!)"
        
        if let percentChange = Double(token.percentChange24h!) {
            
            if percentChange > 0.0 {
                
                variationLabel.textColor = UIColor(red: 91/255, green: 211/255, blue: 0/255, alpha: 1.0)
                variationLabel.text = String(format: "+%@%%", token.percentChange24h!)
                
            } else {
                
                variationLabel.textColor = UIColor(red: 233/255, green: 42/255, blue: 0/255, alpha: 1.0)
                variationLabel.text = String(format: "%@ %%", token.percentChange24h!)
            }

        }

        variationTimeLabel.text = "24h"
        
        priceLabel.text = Value.formattedValue2Dec((token.price?.doubleValue)!)
        totalValueLabel.text = Value.formattedTokenValue(token)

    }
    

}
