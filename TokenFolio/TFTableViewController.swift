//
//  TFTableViewController.swift
//  TokenFolio
//
//  Created by Riccardo Scanavacca on 29/07/2017.
//  Copyright © 2017 Riccardo Scanavacca. All rights reserved.
//

import UIKit

class TFTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.backgroundView = UIImageView(image: UIImage(named: "Backgound.png"))
        
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightMedium)
        header.textLabel?.textColor = UIColor.black
    }
    



}
