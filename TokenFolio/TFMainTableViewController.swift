//
//  TPMainTableViewController.swift
//  TokenFolio
//
//  Created by Riccardo Scanavacca on 22/06/2017.
//  Copyright © 2017 Riccardo Scanavacca. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import CoreData

class TFMainTableViewController: UITableViewController {
    
    let randomArray = ["me", "you", "them"]
    var resultsArray = [Any]()
    var currencies = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Alamofire.request("https://api.coinmarketcap.com/v1/ticker/").responseJSON { (responseData) -> Void in
            if (responseData.result.value) != nil {
                
                if let json = responseData.result.value as? [[String : AnyObject]] {
                    
                    for element in json {
                        
                        let currency = element["name"]
                        
                        self.currencies.append(currency as! String)
                

                    }
                    
                    self.tableView.reloadData()
                    
                }

            }
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return currencies.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        cell.textLabel?.text = currencies[indexPath.row]

        return cell
    }
    
    
 


}
