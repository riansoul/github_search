//
//  LoadingProtocol.swift
//  github_search
//
//  Created by jy choi on 2022/03/08.
//

import Foundation
import UIKit

protocol LoadingProtocol: AnyObject {
    
    var loading: LoadingViewController? { get set }
    
    func showLoading()
    func hideLoading()
}

extension LoadingProtocol where Self: UIViewController {

    func showLoading() {
        if let _ = self as? LoadingViewController {
            return
        }
        
        guard let viewController = instantiateViewController(with: "Common", identifier: "Loading") as? LoadingViewController else { return }
        loading = viewController

        if #available(iOS 13.0, *) {
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
            else { return }
            protocolClass.classWindow = UIWindow(windowScene: windowScene)
        }else {
            protocolClass.classWindow = UIWindow(frame: UIScreen.main.bounds)
        }
        
        protocolClass.classWindow.rootViewController = UIViewController()
        protocolClass.classWindow.windowLevel = UIWindow.Level.alert + 1
        protocolClass.classWindow.makeKeyAndVisible()
        viewController.modalPresentationStyle = .overFullScreen
        protocolClass.classWindow.rootViewController?.present(viewController, animated: false, completion: nil)
    }
    
    
    func hideLoading() {
        loading?.dismiss(animated: false, completion: nil)
        protocolClass.classWindow = nil
    }
    
    
}
