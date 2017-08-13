//
//  TFDetailViewController.swift
//  TokenFolio
//
//  Created by Riccardo Scanavacca on 12/08/2017.
//  Copyright © 2017 Riccardo Scanavacca. All rights reserved.
//

import UIKit

class TFDetailViewController: TFTableViewController {
    
    var token : Token?
    

    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var volume24HrLabel: UILabel!
    @IBOutlet weak var change1hLabel: UILabel!
    @IBOutlet weak var change24HrLabel: UILabel!
    @IBOutlet weak var change7dLabel: UILabel!
    @IBOutlet weak var supplyLabel: UILabel!
    @IBOutlet weak var marketCapLabel: UILabel!
    @IBOutlet weak var quantityTextView: UITextField!

    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = token?.name
        
        configureView()
  
        
    }
    
    func configureView() {
        
        if (token?.price) != nil {
            
            self.priceLabel.text = Value.formattedValue2Dec((token!.price?.doubleValue)!)
            
        } else {
            
            self.priceLabel.text = "N/A"
        }
        
        if (token?.volume24h) != nil {
            
            self.volume24HrLabel.text = Value.formattedValue2Dec(Double((token?.volume24h)!)!)
            
        } else {
            
            self.volume24HrLabel.text = "N/A"
        }
        
        if (token?.availableSupply) != nil {
            
            self.supplyLabel.text =  Value.decimalFormat(Double((token?.availableSupply)!)!) 
            
        } else {
            
            self.supplyLabel.text = "N/A"
        }
        
        if (token?.marketCap) != nil {
            
            self.marketCapLabel.text = Value.formattedValue2Dec(Double((token?.marketCap)!)!)
            
        } else {
            
            self.marketCapLabel.text = "N/A"
        }
        
        self.quantityTextView.text = token?.quantity?.stringValue
        
        
        if let percentChange = Double((token?.percentChange1h!)!) {
            
            if percentChange > 0.0 {
                
                change1hLabel.textColor = UIColor(red: 91/255, green: 211/255, blue: 0/255, alpha: 1.0)
                change1hLabel.text = String(format: "+%@%%", (token?.percentChange1h!)!)
                
            } else {
                
                change1hLabel.textColor = UIColor(red: 233/255, green: 42/255, blue: 0/255, alpha: 1.0)
                change1hLabel.text = String(format: "%@ %%", (token?.percentChange1h!)!)
            }
            
        } else {
            
            change1hLabel.text = "N/A"
        }
        
        if let percentChange = Double((token?.percentChange24h!)!) {
            
            if percentChange > 0.0 {
                
                change24HrLabel.textColor = UIColor(red: 91/255, green: 211/255, blue: 0/255, alpha: 1.0)
                change24HrLabel.text = String(format: "+%@%%", (token?.percentChange24h!)!)
                
            } else {
                
                change24HrLabel.textColor = UIColor(red: 233/255, green: 42/255, blue: 0/255, alpha: 1.0)
                change24HrLabel.text = String(format: "%@ %%", (token?.percentChange24h!)!)
            }
            
        } else {
            
            change24HrLabel.text = "N/A"
        }
        
        if let percentChange = Double((token?.percentChange7d!)!) {
            
            if percentChange > 0.0 {
                
                change7dLabel.textColor = UIColor(red: 91/255, green: 211/255, blue: 0/255, alpha: 1.0)
                change7dLabel.text = String(format: "+%@%%", (token?.percentChange7d!)!)
                
            } else {
                
                change7dLabel.textColor = UIColor(red: 233/255, green: 42/255, blue: 0/255, alpha: 1.0)
                change7dLabel.text = String(format: "%@ %%", (token?.percentChange7d!)!)
            }
            
        } else {
            
            change7dLabel.text = "N/A"
        }
        
        
    }





}
