//
//  UIColor+Extension.swift
//  github_search
//
//  Created by jy choi on 2022/03/07.
//

import UIKit

extension UIColor {
    
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(a) / 255.0)
    }
    
    convenience init(hexString: String, alpha: CGFloat) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (r, g, b) = ((int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (r, g, b) = (int >> 16, int >> 8 & 0xFF, int & 0xFF)
        default:
            (r, g, b) = (0, 0, 0)
        }
        
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: alpha)
    }
    
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        
        getRed(&r, green: &g, blue: &b, alpha: &a)
        
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        
        return String(format:"%06x", rgb)
    }
    
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1.0) {
        self.init(red: r / 255, green: g / 255, blue: b / 255, alpha: a)
    }
    
    func rgb() -> String? {
        var fRed : CGFloat = 0
        var fGreen : CGFloat = 0
        var fBlue : CGFloat = 0
        var fAlpha: CGFloat = 0
        if self.getRed(&fRed, green: &fGreen, blue: &fBlue, alpha: &fAlpha) {
            let iRed    = Int(fRed * 255.0)
            let iGreen  = Int(fGreen * 255.0)
            let iBlue   = Int(fBlue * 255.0)
            
            return "rgb(\(iRed),\(iGreen),\(iBlue))"
        } else {
            return ""
        }
    }
    
    func rgbToColor(colorStr:String) -> UIColor? {
        
        let colorSequence = colorStr.replacingOccurrences(of: "rgb(", with: "").replacingOccurrences(of: ")", with: "")
        let colorArray    = colorSequence.split(separator: ",")
        
        var iRed   :CGFloat = 0
        var iGreen :CGFloat = 0
        var iBlue  :CGFloat = 0
        
        for (index,value) in colorArray.enumerated() {
            if index == 0 {
                if let n = NumberFormatter().number(from: String(value)) {
                    iRed = CGFloat(truncating: n)
                }
            } else if index == 1 {
                if let n = NumberFormatter().number(from: String(value)) {
                    iGreen = CGFloat(truncating: n)
                }
            } else if index == 2 {
                if let n = NumberFormatter().number(from: String(value)) {
                    iBlue = CGFloat(truncating: n)
                }
            }
        }
        return UIColor(r: iRed, g: iGreen, b: iBlue, a: 1)
    }
}


