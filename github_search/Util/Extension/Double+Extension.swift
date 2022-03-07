//
//  Double+Extension.swift
//  github_search
//
//  Created by jy choi on 2022/03/07.
//

import Foundation

extension Double {
    func roundToPlaces(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
