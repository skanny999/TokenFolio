//
//  TFSettingsViewController.swift
//  TokenFolio
//
//  Created by Riccardo Scanavacca on 28/07/2017.
//  Copyright © 2017 Riccardo Scanavacca. All rights reserved.
//

import UIKit

class TFSettingsViewController: TFTableViewController {
    
    @IBOutlet weak var currencyController: UISegmentedControl!
    
    @IBOutlet weak var changeController: UISegmentedControl!
    
    @IBOutlet weak var initialInvestmentTextField: UITextField!

    override func viewDidLoad() {
        
        super.viewDidLoad()

        configureSegmentedControllers()
        
        tableView.backgroundView = UIImageView(image: UIImage(named: "Backgound.png"))
        
    }

    func configureSegmentedControllers() {
        
        let font = UIFont.systemFont(ofSize: 23, weight: UIFont.Weight.medium)
        currencyController.setTitleTextAttributes([NSAttributedString.Key.font: font], for: [])
        changeController.setTitleTextAttributes([NSAttributedString.Key.font: font], for: [])
        
        currencyController.selectedSegmentIndex = Value.currencyIndex()
        
        
    }

    @IBAction func setButtonTapped(_ sender: Any) {
        
        if (initialInvestmentTextField.text?.isValidNumber)! {
            
            TFUserSettings.setInitialInvestment(Double(initialInvestmentTextField.text!)!)
        }

        TFUpdateManager.updateTokens()
        dismiss(animated: true, completion: nil)
        
    }
        
    func configureTitle() {
            
            let titleAttributes = [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.medium)
            ]
            navigationController?.navigationBar.titleTextAttributes = titleAttributes
        
    }
    
    
    @IBAction func currencyControllerTapped(_ sender: Any) {
        
        switch currencyController.selectedSegmentIndex {
        case 0:
            TFUserSettings.setCurrentCurrency(.Usd)
        case 1:
            TFUserSettings.setCurrentCurrency(.Eur)
        case 2:
            TFUserSettings.setCurrentCurrency(.Gbp)
        default:
            TFUserSettings.setCurrentCurrency(.Usd)
        }

        
    }

    @IBAction func changeControllerTapped(_ sender: Any) {
        
        
        
    }





}
