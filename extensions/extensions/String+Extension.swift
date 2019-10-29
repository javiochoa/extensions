//
//  String+Extension.swift
//  OkBoarding
//
//  Created by Javier Gómez Ochoa on 04/09/2019.
//  Copyleft   2019 Javiochoa. Feel free to use it.
//
import Foundation
import UIKit

extension String {
    
//    return localized string from localizable.string
    var localized: String {
        
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
    
    func toBool() -> Bool? {
        
        switch self {
        case "True", "true", "yes", "1":
            return true
        case "False", "false", "no", "0":
            return false
        default:
            return nil
        }
    }
    
    func html2AttributedString(withMaxWidth width: CGFloat?) -> NSAttributedString? {
        
        var text = self
        if let widthUnwrapped:CGFloat = width {
            text = "<style>body{font-family: 'HelveticaNeue-Light'  !important; font-size:18px  !important; text-align: justify;  } img { height: auto; max-width: \(widthUnwrapped); text-align:center; display:block; } a { color: #74C660 !important;} h1 { font-size:20px; font-family: 'HelveticaNeue'  !important;} h2 { font-size:19px; font-family: 'HelveticaNeue-Light'  !important; text-align: left;} h3 { font-size:18px; font-family: 'HelveticaNeue-Light'  !important;} h4 { font-size:17px; font-family: 'HelveticaNeue-Light'  !important;} h5 { font-size:16px; font-family: 'HelveticaNeue-Light'  !important;} </style>\(self)"
        }
        guard
            let data = text.data(using: String.Encoding.utf8)
            else { return nil }
        do {
            return try NSAttributedString(data: data, options: [ NSAttributedString.DocumentReadingOptionKey.documentType:NSAttributedString.DocumentType.html,
                                                                 NSAttributedString.DocumentReadingOptionKey.characterEncoding: String.Encoding.utf8.rawValue,
                                                                 NSAttributedString.DocumentReadingOptionKey(rawValue: NSAttributedString.Key.link.rawValue): UIColor.red,
                                                                 NSAttributedString.DocumentReadingOptionKey(rawValue: NSAttributedString.Key.foregroundColor.rawValue): UIColor.red],
                                          documentAttributes: nil)
        } catch let error as NSError {
            print(error.localizedDescription)
            return  nil
        }
    }
    
    var html2String: String {
        
        return self.html2AttributedString(withMaxWidth: nil)?.string ?? ""
    }
    
    subscript (i: Int) -> Character {
        
        return self[index(startIndex, offsetBy: i)]
    }
    
    subscript (i: Int) -> String {
        
        return String(self[i] as Character)
    }
    
    func fromBase64() -> String? {
        
        guard let data = Data(base64Encoded: self) else {
            return nil
        }
        
        return String(data: data, encoding: .utf8)
    }
    
    func toBase64() -> String {
        
        return Data(self.utf8).base64EncodedString()
    }
    
    func toDate() -> Date? {
        
        let formats:[String] = ["yyyy-MM-dd'T'HH:mm:ssZ", "yyyy-MM-dd HH:mm:ss Z", "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"] //Add formats that your app can need
        let dateFormatter = DateFormatter()
        for format in formats {
            
            dateFormatter.dateFormat = format
            if let date = dateFormatter.date(from: self) {
                return date
            }
        }
        return nil
    }
    
    static func random(_ length: Int = 20) -> String {
        
        let base = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var randomString: String = ""
        
        for _ in 0..<length {
            let randomValue = Int(arc4random_uniform(UInt32(base.count)))
            randomString.append(base[base.index(base.startIndex, offsetBy: randomValue)])
        }
        
        return randomString
    }
    
    func isValidEmail() -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(boundingBox.height)
    }
    
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(boundingBox.width)
    }
}
