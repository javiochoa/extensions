//
//  URL+Extension.swift
//  OkBoarding
//
//  Created by Javier Gómez Ochoa on 11/09/2019.
//  Copyleft   2019 Javiochoa. Feel free to use it.
//

import Foundation

extension URL {
    
    var typeIdentifier: String? {
        
        return (try? resourceValues(forKeys: [.typeIdentifierKey]))?.typeIdentifier
    }
    
    var localizedName: String? {
        
        return (try? resourceValues(forKeys: [.localizedNameKey]))?.localizedName
    }
    
    func solve(completion: @escaping (Data) -> (), onError: @escaping (Error?) -> ()) {
        
        URLSession.shared.dataTask(with: self) { data, response, error in
            guard let data = data  else {
                return onError(error)
            }
            completion(data)
            }.resume()
    }
}
