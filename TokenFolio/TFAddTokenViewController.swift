//
//  TFAddTokenViewController.swift
//  TokenFolio
//
//  Created by Riccardo Scanavacca on 15/07/2017.
//  Copyright © 2017 Riccardo Scanavacca. All rights reserved.
//

import UIKit

class TFAddTokenViewController: UIViewController {

    @IBOutlet weak var tokenPicker: UIPickerView!
    @IBOutlet weak var selectTokenLabel: UILabel!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tokenPicker.isHidden = true


    }


}
