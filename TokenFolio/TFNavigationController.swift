//
//  TFNavigationController.swift
//  TokenFolio
//
//  Created by Riccardo Scanavacca on 29/07/2017.
//  Copyright © 2017 Riccardo Scanavacca. All rights reserved.
//

import UIKit

class TFNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let titleAttributes = [
            NSFontAttributeName: UIFont.systemFont(ofSize: 24, weight: UIFontWeightMedium)
        ]
        
        navigationBar.titleTextAttributes = titleAttributes
        
        navigationBar.tintColor = UIColor.black
        
        setBottomBorderColor()
        
    }
    
    
    func setBottomBorderColor() {
        let bottomBorderRect = CGRect(x: 0, y: navigationBar.frame.height, width: navigationBar.frame.width, height: 1.0)
        let bottomBorderView = UIView(frame: bottomBorderRect)
        bottomBorderView.backgroundColor = UIColor.black
        navigationBar.addSubview(bottomBorderView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
