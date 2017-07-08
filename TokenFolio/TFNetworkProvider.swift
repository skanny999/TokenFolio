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
        
        let baseURL = URL(string: "https://api.coinmarketcap.com/v1/ticker/?limit=100")!
        
        let task = URLSession.shared.dataTask(with: baseURL) { (data, response, error) in
            
            if let data = data {
                let updateManager = TFUpdateManager()
                
                updateManager.parseJON(json: data)
            }
        }
        
        task.resume()
    }
    
    
    
}


