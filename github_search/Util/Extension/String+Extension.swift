//
//  String+Extension.swift
//  github_search
//
//  Created by jy choi on 2022/03/09.
//

import Foundation

extension String {
    
    var getDate : Date {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: localeKr)
        dateFormatter.dateFormat = formatUpdateAt
        let date:Date = dateFormatter.date(from: self) ?? Date()
        return date
    }
    
}
