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
    
    var picker = UIPickerView()
    
    var tokens = [Token]()
    var token : Token?

    override func viewDidLoad() {
        super.viewDidLoad()

        loadTokens()
        configureGestureRecogniser()
        selectTokenLabel.text = "Select Token"
        quantityTextField.delegate = self
//        quantityTextField.isEnabled = false

    }
    

    
    func loadTokens() {
        
        TFCoreDataProvider.shared.fetchAllTokens { (fetchedTokens) in
            
            print("Fetched tokens: %@", fetchedTokens)
            
            self.tokens = fetchedTokens
            self.configurePicker()

        }
    }
    
    
    func configureGestureRecogniser() {
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(TFAddTokenViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    
    func updateLabelsForToken (_ token : Token) {
        
        selectTokenLabel.text = token.name
        quantityTextField.text = token.quantity?.stringValue
        currentPriceLabel.text = Value.formattedTokenPrice(token)
    }
    
    
    @IBAction func addButtonTapped(_ sender: Any) {
        
        if token == nil {
            
            showAlertWithText("Please select token")
            
        } else if !(quantityTextField.text?.isNumber)!  {
            
            showAlertWithText("Please enter a valid quantity")
            
        } else {
            
            token?.isSelected = true
            token?.quantity =  NSNumber(value:Double(quantityTextField.text!)!)
            Value.setTotalValueForToken(token!)
            
            dismiss(animated: true, completion: nil)

        }
    }

    
    
    @IBAction func dismissButtonTapped(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    

    @IBAction func selectTokenLabelTapped(_ sender: Any) {
        
        dismissKeyboard()
        showPicker()
        
        if token == nil {
            token = tokens[0]
            updateLabelsForToken(token!)
        }
    }
}



extension TFAddTokenViewController: UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    func configurePicker() {
        
        picker = UIPickerView(frame: CGRect(x: 0,
                                            y: self.view.bounds.size.height,
                                            width: self.view.bounds.width,
                                            height: 224))
        view.addSubview(picker)

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
        
//        quantityTextField.isEnabled = true
        token = tokens[row]
        updateLabelsForToken(token!)
    }
    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if token != nil {
            
            return true
        }
        else {

            showAlertWithText("Please select a token before adding a quantity")
            
            return false
        }

    }
    
    
    
    func showPicker() {
        UIView.animate(withDuration: 0.3, animations: {
            self.picker.frame = CGRect(x: 0,
                                       y: self.view.bounds.size.height - self.picker.bounds.size.height,
                                       width: self.picker.bounds.size.width,
                                       height: self.picker.bounds.size.height)
            
        })
    }
    
    
    func hidePicker() {

        UIView.animate(withDuration: 0.3, animations: {
            self.picker.frame = CGRect(x: 0,
                                       y: self.view.bounds.size.height,
                                       width: self.picker.bounds.size.width,
                                       height: 224)
        })
    }
    
    
    func dismissKeyboard() {
        
        view.endEditing(true)
        hidePicker()
    }
    
    
    func showAlertWithText(_ text: String) {
        
        let alert = UIAlertController(title: "Alert", message: text, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
    
    
}


