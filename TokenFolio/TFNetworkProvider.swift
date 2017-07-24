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
    
    func fetchJSON() {
        
        let url = URL(string: "https://api.coinmarketcap.com/v1/ticker/?limit=10")!
        
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


