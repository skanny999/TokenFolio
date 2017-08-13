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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = token?.name
        
        
    }





}
