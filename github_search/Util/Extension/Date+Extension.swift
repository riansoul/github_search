//
//  Date+Extension.swift
//  github_search
//
//  Created by jy choi on 2022/03/09.
//

import Foundation

extension Date {
    var upDateAt : String {
        let upDateTime:Date = self
        let currentDateTime:Date = Date()
        let userCalendar = Calendar.current
        let requestedComponents: Set<Calendar.Component> = [
            .day,
            .month,
            .year,
            .hour,
            .minute
        ]
        
        let dateGap = userCalendar.dateComponents(requestedComponents, from: upDateTime, to: currentDateTime)
//        let upDateTimeComponents = userCalendar.dateComponents(requestedComponents, from: upDateTime)
//        let currentDateComponents = userCalendar.dateComponents(requestedComponents, from: currentDateTime)
        
        let year   : Int = dateGap.year ?? 0
        let month  : Int = dateGap.month ?? 0
        let day    : Int = dateGap.day ?? 0
        let hour   : Int = dateGap.hour ?? 0
        let minute : Int = dateGap.minute ?? 0
        
        if year > 0 {
            return String(format: updateYear, upDateTime.dateYear)
        }
         
        if month > 0 {
            return String(format: updateMonth, upDateTime.dateMonth)
        }
        
        if day > 0 {
            return String(format: updateDay, day)
        }
        
        if hour > 0 {
            return String(format: updateHour, hour)
        }
        
        return String(format: updateMinutes, minute)
    }
    
    var dateMonth : String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: localeUs)
        dateFormatter.dateFormat = formatMonth
        let date:String = dateFormatter.string(from: self)
        return date
    }
    
    var dateYear : String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: localeUs)
        dateFormatter.dateFormat = formatYear
        let date:String = dateFormatter.string(from: self)
        return date
    }
}
