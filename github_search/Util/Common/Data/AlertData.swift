//
//  AlertData.swift
//  github_search
//
//  Created by jy choi on 2022/03/08.
//

import Foundation
import UIKit

struct AlertData {
    var title       : String?
    var message     : String
    var buttons     : [AlertButtonData]
    
    init(title: String? = "Kurly Proj App", message: String, buttons: [AlertButtonData]) {
        self.title = title
        self.message = message
        self.buttons = buttons        
    }
}

struct AlertButtonData {
    let text : String
    let buttonType : UIAlertAction.Style
    let handler: (()-> Void)?
    
    init(text: String, buttonType:UIAlertAction.Style = .default, handler:(() -> Void)? = nil) {
        self.text = text
        self.buttonType = buttonType
        self.handler = handler
    }
    
    static func cancelButton(text:String, handler:(()->Void)? = nil) -> AlertButtonData {
        return AlertButtonData.init(text: text, buttonType: .cancel, handler: handler)
    }
}
