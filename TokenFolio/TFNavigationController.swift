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

        setBottomBorderColor()
        setTitleTextAttributes()
        setButtonTextAttributes()
        
    }
    
    
    func setBottomBorderColor() {
        let bottomBorderRect = CGRect(x: 0, y: navigationBar.frame.height, width: navigationBar.frame.width, height: 1.0)
        let bottomBorderView = UIView(frame: bottomBorderRect)
        bottomBorderView.backgroundColor = UIColor.black
        navigationBar.addSubview(bottomBorderView)
    }
    
    func setTitleTextAttributes() {
        
        let titleAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 24, weight: UIFontWeightMedium)]
        navigationBar.titleTextAttributes = titleAttributes
        navigationBar.tintColor = UIColor.black
        

        
    }

    func setButtonTextAttributes() {
        
        let customFont = UIFont.systemFont(ofSize: 18, weight: UIFontWeightMedium)
        UIBarButtonItem.appearance().setTitleTextAttributes([NSFontAttributeName: customFont], for: .normal)
        
//        navigationBar.topItem?.title = " "
        
    }
    



}
