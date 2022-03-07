//
//  UIViewController+Extension.swift
//  github_search
//
//  Created by jy choi on 2022/03/07.
//

import Foundation
import RxSwift

extension UIViewController: StoryboardSupportProtocol {

}

extension UIViewController {
        
    func addChild(viewController child: UIViewController, targetView: UIView? = nil, animated: Bool = true, completion: (() -> Void)? = nil) {
        addChild(child)
        child.view.translatesAutoresizingMaskIntoConstraints = false
        
        if let target = targetView {
            target.addSubviewAutoLayout(child.view)
        } else {
            view.addSubviewAutoLayout(child.view)
        }
        
        if animated {
            child.view.alpha = 0.0
            UIView.animate(withDuration: 0.3, animations: {
                child.view.alpha = 1.0
            }, completion: { [weak self] _ in
                guard let `self` = self else { return }
                
                child.didMove(toParent: self)
                self.setNeedsStatusBarAppearanceUpdate()
                child.view.window?.makeKeyAndVisible()
                
                completion?()
            })
        } else {
            child.didMove(toParent: self)
            setNeedsStatusBarAppearanceUpdate()
            child.view.window?.makeKeyAndVisible()
            completion?()
        }
    }
    
    func removeChild(viewController child: UIViewController?, animated: Bool = true, completion: (() -> Void)? = nil) {
        guard let child = child else { return }
        
        let parent = child.parent
        
        child.willMove(toParent: nil)
        
        if animated {
            UIView.animate(withDuration: 0.3, animations: {
                child.view.alpha = 0.0
            }, completion: { _ in
                child.view.removeFromSuperview()
                child.removeFromParent()
                parent?.setNeedsStatusBarAppearanceUpdate()
                child.view.window?.makeKeyAndVisible()
                parent?.view.window?.makeKeyAndVisible()
                completion?()
            })
        } else {
            child.view.removeFromSuperview()
            child.removeFromParent()
            parent?.setNeedsStatusBarAppearanceUpdate()
            child.view.window?.makeKeyAndVisible()
            parent?.view.window?.makeKeyAndVisible()
            completion?()
        }
    }
    
    func back() {
        back(nil)
    }
    
    func back(_ handler: (() -> Void)? = nil) {
        if parent != nil && !(parent is UINavigationController) {
            removeChild(viewController: self)
        } else if presentingViewController != nil {
            dismiss(animated: true, completion: { handler?() })
        } else if let navigationController = navigationController {
            navigationController.popViewController(animated: true)
        }
    }
    
    func backToRoot() {
        if let navigationController = navigationController {
            navigationController.popToRootViewController(animated: true)
        }
    }
    
    var isPortrait: Bool {
        let orientation = UIDevice.current.orientation
        switch orientation {
        case .portrait, .portraitUpsideDown:
            return true
        case .landscapeLeft, .landscapeRight:
            return false
        default: // unknown or faceUp or faceDown
            if #available(iOS 13.0, *) {
                return UIApplication.shared.windows
                    .first?
                    .windowScene?
                    .interfaceOrientation
                    .isPortrait ?? false
            } else {
                return UIApplication.shared.statusBarOrientation.isPortrait
            }
        }
    }
}
