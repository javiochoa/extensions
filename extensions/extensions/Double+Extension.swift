//
//  Double+Extension.swift
//  OkBoarding
//
//  Created by Javier Gómez Ochoa on 04/09/2019.
//  Copyleft   2019 Javiochoa. Feel free to use it.
//

import Foundation

extension Double {
    
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
