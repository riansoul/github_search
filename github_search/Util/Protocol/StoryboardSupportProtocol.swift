//
//  StoryboardSupportProtocol.swift
//  github_search
//
//  Created by jy choi on 2022/03/07.
//

import UIKit

protocol StoryboardSupportProtocol {
    
}

extension StoryboardSupportProtocol {
    
    func instantiateInitialViewController(with name: String) -> UIViewController? {
        return UIStoryboard(name: name, bundle: nil).instantiateInitialViewController()
    }
    
    func instantiateViewController(with name: String, identifier: String) -> UIViewController? {
        return UIStoryboard(name: name, bundle: nil).instantiateViewController(withIdentifier: identifier)
    }
}

extension StoryboardSupportProtocol where Self: UIViewController {
    
    func performSegue<T>(type: T, sender: Any?) {
        let className = String(describing: type).replacingOccurrences(of: "ViewController", with: "")
        performSegue(withIdentifier: className, sender: sender)
    }
}


