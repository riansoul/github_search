//
//  UIWindow+Extension.swift
//  github_search
//
//  Created by jy choi on 2022/03/07.
//

import UIKit

extension UIWindow {

    func rootViewController(_ viewController: UIViewController, animate: Bool) {
        if animate {
            guard let root = rootViewController, let snapshot = root.view else {
                rootViewController = viewController
                return
            }
            
            viewController.view?.addSubview(snapshot)
            
            rootViewController = viewController
            
            UIView.animate(withDuration: 0.3, animations: {
                snapshot.layer.opacity = 0
            }, completion: { finished in
                snapshot.removeFromSuperview()
            })
        } else {
            rootViewController = viewController
        }
    }
}



