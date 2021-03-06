//
//  TFAddViewController.swift
//  TokenFolio
//
//  Created by Riccardo Scanavacca on 29/07/2017.
//  Copyright © 2017 Riccardo Scanavacca. All rights reserved.
//

import UIKit

class TFAddViewController: TFTableViewController {

    
    @IBOutlet weak var selectTokenLabel: UILabel!
    @IBOutlet weak var currentPriceLabel: UILabel!
    @IBOutlet weak var quantityTextField: UITextField!
    
    var picker = UIPickerView()
    
    var tokens = [Token]()
    var token : Token?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadTokens()
        selectTokenLabel.text = "Select Token"
        quantityTextField.delegate = self
        
    }
    
    
    
    func loadTokens() {
        
        TFCoreDataProvider.shared.fetchAllTokens { (fetchedTokens) in
            
            self.tokens = fetchedTokens
            self.configurePicker()
            
        }
    }
    
    
    
    func updateLabelsForToken (_ token : Token) {
        
        selectTokenLabel.updateWithText(token.name!)
        quantityTextField.text = token.quantity?.stringValue
        currentPriceLabel.updateWithText(Value.formattedValue2Dec((token.price?.doubleValue)!))
    }
    
    
    @IBAction func addButtonTapped(_ sender: Any) {
        
        if token == nil {
            
            showAlertWithText("Please select token")
            
        } else if !(quantityTextField.text?.isValidNumber)!  {
            
            showAlertWithText("Please enter a valid quantity")
            
        } else {
            
            token!.isSelected = true
            token!.quantity =  NSNumber(value:Double(quantityTextField.text!)!)
            token!.totalValue = NSNumber(value: (token?.quantity?.doubleValue)! * (token?.price?.doubleValue)!)
            
            print(token!)
            
            TFCoreDataProvider.shared.save()
            
            hidePicker()
            dismiss(animated: true, completion: nil)
            
        }
    }
    
    
    
    @IBAction func dismissButtonTapped(_ sender: Any) {
        
        hidePicker()
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 && indexPath.row == 0 {
            
            dismissKeyboard()
            showPicker()
            
            if token == nil {
                token = tokens[0]
                updateLabelsForToken(token!)
            }
        } else {
            
            hidePicker()
        }
        
    }
    
    
    func showAlertWithText(_ text: String) {
        
        let alert = UIAlertController(title: "Alert", message: text, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
}



extension TFAddViewController: UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    func configurePicker() {
        
        let window = UIApplication.shared.keyWindow!
        picker = UIPickerView(frame: CGRect(x: 0,
                                            y: window.bounds.size.height,
                                            width: window.bounds.width,
                                            height: 150))

        picker.layer.borderColor = UIColor.black.cgColor
        picker.layer.borderWidth = 1
        window.addSubview(picker)
        picker.delegate = self
        picker.dataSource = self
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        let token = tokens[row]
        let myTitle = NSAttributedString(string: token.name!, attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 22, weight: UIFont.Weight.regular),NSAttributedString.Key.foregroundColor:UIColor.black])
        pickerLabel.attributedText = myTitle
        pickerLabel.textAlignment = .center
        pickerLabel.backgroundColor = UIColor.white
        pickerView.backgroundColor = UIColor.white
        return pickerLabel
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
            
            let indexPath = NSIndexPath(row: 0, section: 1)
            
            self.tableView.scrollToRow(at: indexPath as IndexPath, at: UITableView.ScrollPosition.middle, animated: true)
            
            let window = UIApplication.shared.keyWindow!
            self.picker.frame = CGRect(x: 0,
                                       y: window.bounds.size.height - self.picker.bounds.size.height,
                                       width: self.picker.bounds.size.width,
                                       height: self.picker.bounds.size.height)
            
        })
    }
    
    
    func hidePicker() {
        
        UIView.animate(withDuration: 0.3, animations: {
            let window = UIApplication.shared.keyWindow!
            self.picker.frame = CGRect(x: 0,
                                       y: window.bounds.size.height,
                                       width: self.picker.bounds.size.width,
                                       height: 150)
        })
    }
    
    
    func dismissKeyboard() {
        
        view.endEditing(true)
        hidePicker()
    }
    

}


















