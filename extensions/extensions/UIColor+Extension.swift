//
//  UIColor+Extension.swift
//  OkBoarding
//
//  Created by Javier Gómez Ochoa on 04/09/2019.
//  Copyleft   2019 Javiochoa. Feel free to use it.
//

import UIKit

extension UIColor {
    
    @nonobjc class var mainColor: UIColor {
        return UIColor(red: 61.0 / 255.0, green: 180.0 / 255.0, blue: 229.0 / 255.0, alpha: 1.0)
    }
    @nonobjc class var lightColor: UIColor {
        return UIColor(white: 237.0 / 255.0, alpha: 1.0)
    }
    @nonobjc class var darkColor: UIColor {
        return UIColor(red: 68.0 / 255.0, green: 68.0 / 255.0, blue: 68.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var backgroundColor: UIColor {
        return UIColor(red: 160.0 / 255.0, green: 165.0 / 255.0, blue: 169.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var errorColor: UIColor {
        return UIColor(red: 208.0 / 255.0, green: 2.0 / 255.0, blue: 27.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var textColor: UIColor {
        return UIColor(red: 206.0 / 255.0, green: 208.0 / 255.0, blue: 210.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var gradientLightColor: UIColor {
        return UIColor(red: 206.0 / 255.0, green: 208.0 / 255.0, blue: 210.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var gradientDarkColor: UIColor {
        return UIColor(red: 206.0 / 255.0, green: 208.0 / 255.0, blue: 210.0 / 255.0, alpha: 1.0)
    }
}

