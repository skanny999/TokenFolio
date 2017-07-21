//
//  TFAddTokenViewController.swift
//  TokenFolio
//
//  Created by Riccardo Scanavacca on 15/07/2017.
//  Copyright © 2017 Riccardo Scanavacca. All rights reserved.
//

import UIKit


class TFAddTokenViewController: UIViewController {


    @IBOutlet weak var selectTokenTextField: UITextField!
    @IBOutlet weak var currentPriceLabel: UILabel!
    @IBOutlet weak var quantityTextField: UITextField!
    
    var picker = UIPickerView()
    
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
        
        selectTokenTextField.text = token.name
        quantityTextField.text = token.quantity?.stringValue
        
        switch TFUserSettings.currentCurrency()!{
        case .Usd:
            currentPriceLabel.text = TFFormatter.currencyFromNumber(token.priceUsd!)
        case .Eur:
            currentPriceLabel.text = TFFormatter.currencyFromNumber(token.priceEur!)
        case .Gbp:
            currentPriceLabel.text = TFFormatter.currencyFromNumber(token.priceGbp!)
        default:
            currentPriceLabel.text = "N/A"
        }
    }
    
    
    
    @IBAction func addButtonTapped(_ sender: Any) {
        
        if tokens.contains(token) {
            
            token.isSelected = true
            token.quantity =  NSNumber(value:Int32(quantityTextField.text!)!)
            Value.setTotalValueForToken(token)
            
            dismiss(animated: true, completion: nil)
            
        } else {
            
            let alert = UIAlertController(title: "Alert", message: "Please select token and add a quantity", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    
    
    
    @IBAction func dismissButtonTapped(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
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
        
        selectTokenTextField.inputView = picker
        picker.delegate = self
        picker.dataSource = self
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
