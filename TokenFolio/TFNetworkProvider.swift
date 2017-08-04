//
//  TFServicesProvider.swift
//  TokenFolio
//
//  Created by Riccardo Scanavacca on 24/06/2017.
//  Copyright © 2017 Riccardo Scanavacca. All rights reserved.
//

import UIKit
import CoreData

class TFNetworkProvider {
    
    static func fetchJSON() {
        
        let urlString = String(format:"https://api.coinmarketcap.com/v1/ticker/?convert=\(Value.currencyCode())&limit=100")
        
        let url = URL(string: urlString)!
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let data = data {
                let updateManager = TFUpdateManager()
                
                updateManager.parseJON(json: data)
            }
            
            if let response = response as? HTTPURLResponse {
                
                print(response)
            }
            
            if let error = error {
                
                print("Error connecting to the server: \(error)")
            }
        }
        
        task.resume()
    }

    
    
    
}


