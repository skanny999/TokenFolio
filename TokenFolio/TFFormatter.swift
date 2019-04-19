//
//  TFStrings.swift
//  TokenFolio
//
//  Created by Riccardo Scanavacca on 20/07/2017.
//  Copyright © 2017 Riccardo Scanavacca. All rights reserved.
//

import Foundation
import UIKit


extension String  {
    
    var isValidNumber : Bool {
        
        return Double(self) != nil && Double(self) != 0.0 ? true : false
    }
}

extension UIView {
    func fadeIn(_ duration: TimeInterval = 0.2, delay: TimeInterval = 0.0, completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.alpha = 1.0
        }, completion: completion)  }
    
    func fadeOut(_ duration: TimeInterval = 0.2, delay: TimeInterval = 0.0, completion: @escaping (Bool) -> Void = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.alpha = 0.0
        }, completion: completion)
    }
}


extension UILabel {
    
    func updateWithText(_ text: String) {
    
        self.fadeOut()
        self.text = text
        self.fadeIn()
    } 
}























