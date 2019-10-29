//
//  UILabel+Extension.swift
//  OkBoarding
//
//  Created by Javier Gómez Ochoa on 29/10/2019.
//  Copyleft   2019 Javiochoa. Feel free to use it.
//

import Foundation
import UIKit

extension UILabel {
   
    var estimatedWidth: CGFloat {
        
        return self.intrinsicContentSize.width
    }
}
