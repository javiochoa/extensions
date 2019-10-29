//
//  Date+Extension.swift
//  OkBoarding
//
//  Created by Javier Gómez Ochoa on 04/09/2019.
//  Copyleft   2019 Javiochoa. Feel free to use it.
//

import Foundation

extension Date {
    
    
    func toString(withFormat dateFormat:String) -> String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        return formatter.string(from: self)
    }
    
    func asDefault() -> String  {
        
        return self.toString(withFormat: "dd/MM/yyyy | HH:mm")
    }
    
    func asDefaultMonth() -> String  {
        
        return self.toString(withFormat: "dd - MMMM | HH:mm")
    }
    
    func asDotted() -> String  {
        
        return self.toString(withFormat: "dd.MM.yyyy")
    }
    
    func asScripted() -> String  {
        
        return self.toString(withFormat: "dd-MM-yyyy HH:mm")
    }
    
    func asHourMinute() -> String {
        
        return self.toString(withFormat: "hh:mm")
    }
    
    func asTimestamp() -> String {
        
        return "\(self.timeIntervalSince1970)"
    }
    
    func asRequestFormat() -> String {
        
        return self.toString(withFormat: "yyyy-MM-dd'T'HH:mm:ss")
    }
    
    func days(from date: Date) -> Int {
        
        return Calendar.current.dateComponents([.day], from: date, to: self).day!
    }
    
    func increase(days:Int) -> Date {
        
        var dateComponent = DateComponents()
        dateComponent.day = days
        return Calendar.current.date(byAdding: dateComponent, to: self)!
    }
    
    func isNewest(thanDate:Date) -> Bool {
        
        return self < thanDate
    }
    
    func convertToLocalTime(fromTimeZone timeZoneAbbreviation: String) -> Date? {
        
        if let timeZone = TimeZone(identifier: timeZoneAbbreviation) {
            let targetOffset = TimeInterval(timeZone.secondsFromGMT(for: self))
            let localOffeset = TimeInterval(TimeZone.autoupdatingCurrent.secondsFromGMT(for: self))
            
            return self.addingTimeInterval(targetOffset - localOffeset)
        }
        return nil
    }
}
