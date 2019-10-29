//
//  UIFont+Extension.swift
//  OkBoarding
//
//  Created by Javier Gómez Ochoa on 04/09/2019.
//  Copyleft   2019 Javiochoa. Feel free to use it.
//

import UIKit

extension UIFont {
    
    class var main: UIFont {
        return UIFont(name: "Helvetica-Neue", size: 30.0)!
    }
    
    class var title: UIFont {
        return UIFont.systemFont(ofSize: 30.0)
    }
    
    class var link: UIFont {
        return UIFont.systemFont(ofSize: 14.0)
    }
    
    class var navBarFont: UIFont {
        return UIFont.systemFont(ofSize: 16.0)
    }
    
    class var text: UIFont {
        return UIFont.systemFont(ofSize: 18.0)
    }
}
