//
//  Int+Extension.swift
//  github_search
//
//  Created by jy choi on 2022/03/07.
//

import Foundation

extension Int {
    var count:String{
        let num = Double(self)
        let thousandNum = num/1000
        let millionNum = num/1000000
        if num >= 1000 && num < 1000000{
            if(floor(thousandNum) == thousandNum){
                return("\(Int(thousandNum))k")
            }
            return("\(thousandNum.roundToPlaces(places: 1))k")
        }
        if num > 1000000{
            if(floor(millionNum) == millionNum){
                return("\(Int(thousandNum))k")
            }
            return ("\(millionNum.roundToPlaces(places: 1))M")
        }
        else{
            if(floor(num) == num){
                return ("\(Int(num))")
            }
            return ("\(num)")
        }
    }
    
    var decimal:String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let formatterNumber = numberFormatter.string(from: NSNumber(value:self))
        return formatterNumber ?? ""
    }
    
}
