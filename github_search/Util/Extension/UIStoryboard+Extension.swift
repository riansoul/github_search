//
//  UIStoryboard+Extension.swift
//  github_search
//
//  Created by jy choi on 2022/03/07.
//

import Foundation
import UIKit

extension UIStoryboard {
    
    convenience init(_ name: String) {
        self.init(name: name, bundle: nil)
    }
    
    func initial() -> UIViewController? {
        return instantiateInitialViewController()
    }
    
    func identifier(_ name: String) -> UIViewController {
        return instantiateViewController(withIdentifier: name)
    }
}
