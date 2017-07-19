//
//  TFAddTokenViewController.swift
//  TokenFolio
//
//  Created by Riccardo Scanavacca on 15/07/2017.
//  Copyright © 2017 Riccardo Scanavacca. All rights reserved.
//

import UIKit


class TFAddTokenViewController: UIViewController {


    @IBOutlet weak var selectTokenLabel: UILabel!
    @IBOutlet weak var currentPriceLabel: UILabel!
    @IBOutlet weak var quantityTextField: UITextField!
    
    @IBOutlet weak var tokenPicker: UIPickerView!
    
    var tokens = [Token]()
    var token = Token()

    override func viewDidLoad() {
        
        super.viewDidLoad()

        loadTokens()
        
    }
    
    func loadTokens() {
        
        let coreDataProvider = TFCoreDataProvider()
        
        coreDataProvider.fetchAllTokens { (fetchedTokens) in
            
            self.tokens = fetchedTokens
            self.configurePicker()

        }
    }
    
    func updateLabelsForToken (_ token : Token) {
        
        selectTokenLabel.text = token.name
        quantityTextField.text = token.quantity?.stringValue
        
        let currency = TFUserSettings.currentCurrency()!
        
        switch currency {
        case .Usd:
            currentPriceLabel.text = stringPriceForCurrency(token.priceUsd!, .Usd)
        case .Eur:
            currentPriceLabel.text = stringPriceForCurrency(token.priceEur!, .Eur)
        case .Gbp:
            currentPriceLabel.text = stringPriceForCurrency(token.priceGbp!, .Gbp)
        default:
            currentPriceLabel.text = "N/A"
        }
        
    }
    
    func stringPriceForCurrency(_ price: NSNumber, _ currency: Currency) -> String {

        let symbol : String
        
        switch currency {
        case .Usd:
            symbol = "$"
        case .Eur:
            symbol = "€"
        case .Gbp:
            symbol = "£"
        default:
            symbol = "$"
        }
        
        return String(format: "%@ %.2f", symbol, price.doubleValue)
    }

}

extension TFAddTokenViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func configurePicker() {
        
        tokenPicker.delegate = self
        tokenPicker.dataSource = self
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return tokens.count
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return tokens[row].name
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        token = tokens[row]
        updateLabelsForToken(token)
        
    }
    
}
