//
//  UIButton+Extension.swift
//  OkBoarding
//
//  Created by Javier Gómez Ochoa on 04/09/2019.
//  Copyleft   2019 Javiochoa. Feel free to use it.
//

import UIKit
import Foundation

extension UIButton {
    
    func bordered() {
        
        self.bordered(withColor: UIColor.mainColor, borderWidth: 2)
        self.roundCorners(radius: 4.0)
    }
    
    func configureAsEnable() {
        
        self.addGradient()
        self.roundCorners()
        self.layer.borderWidth = 0
        self.setTitleColor(.white, for: .normal)
    }
    
    func configureAsDisable() {
        
        self.removeGradient()
        self.bordered()
        self.layer.borderWidth = 1
        self.setTitleColor(UIColor.mainColor, for: .normal)
    }
    
}
