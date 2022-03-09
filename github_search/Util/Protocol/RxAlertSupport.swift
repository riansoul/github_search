//
//  RxAlertSupport.swift
//  github_search
//
//  Created by jy choi on 2022/03/08.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

struct RxAlertSupportData {
    var show = BehaviorRelay<AlertData?>(value: nil)
}

protocol RxAlertSupport {
    
    var alert: RxAlertSupportData { get }
}

extension RxAlertSupport {
    
    func showAlert(with data: AlertData) {
        alert.show.accept(data)
    }
    
    func showAlert(with message: String, buttons: [AlertButtonData]? = nil) {
        if let buttons = buttons {
            alert.show.accept(AlertData(message: message, buttons: buttons))
        } else {
            let button = AlertButtonData(text: confirmButton)
            alert.show.accept(AlertData(message: message, buttons: [button]))
        }
    }
        
    func showAlert(with message: String, retry: (() -> Void)?, cancel: Bool = false) {
        if cancel {
            let cancel = AlertButtonData(text: cancelButton, buttonType: .cancel)
            let retry = AlertButtonData(text: retryButton, handler: retry)
            let alert = AlertData(message: message, buttons: [cancel, retry])
            showAlert(with: alert)
        } else {
            let retry = AlertButtonData(text: retryButton, handler: retry)
            let alert = AlertData(message: message, buttons: [retry])
            showAlert(with: alert)
        }
    }
}

