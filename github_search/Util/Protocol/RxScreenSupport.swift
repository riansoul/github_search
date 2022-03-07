//
//  RxScreenSupport.swift
//  github_search
//
//  Created by jy choi on 2022/03/07.
//

import UIKit
import RxCocoa
import RxSwift

enum ScreenShowType {
    case push
    case present
}

enum ScreenHideType {
    case pop
    case dismiss
    case back
}

struct RxScreenSupportData {

    var show        = BehaviorRelay<(type: ScreenShowType, viewController: UIViewController, animate: Bool, replace: Bool)?>(value: nil)
    var hide        = BehaviorRelay<(type: ScreenHideType, animate: Bool)?>(value: nil)
    var root        = BehaviorRelay<(viewController: UIViewController, animate: Bool)?>(value: nil)
    var dismiss     = BehaviorRelay<String?>(value: nil)
    var add         = BehaviorRelay<UIViewController?>(value: nil)
    var remove      = BehaviorRelay<UIViewController?>(value: nil)
    var removeName  = BehaviorRelay<String?>(value: nil)
    var unwind      = BehaviorRelay<String?>(value: nil)
}

protocol RxScreenSupport {
    var screen : RxScreenSupportData { get }
}

extension RxScreenSupport {
    
    func present(viewController: UIViewController, animate : Bool = true) {
        screen.show.accept((ScreenShowType.present, viewController, animate, false))
    }
    
    func push(viewController: UIViewController, animate: Bool = true, replace: Bool = false) {
        screen.show.accept((ScreenShowType.push, viewController, animate, replace))
    }
    
    func hide(type: ScreenHideType, animate: Bool = true) {
        screen.hide.accept((type, animate))
    }
    
    func back() {
        back(animate: true)
    }
    
    func back(animate: Bool = true) {
        screen.hide.accept((type: ScreenHideType.back, animate: animate))
    }
    
    func pop() {
        pop(animate: true)
    }
    
    func pop(animate: Bool = true) {
        screen.hide.accept((type: ScreenHideType.pop, animate: animate))
    }
    
    func dismiss<T>(type: T) {
        let targetName = String(describing: type)
        screen.dismiss.accept(targetName)
    }
    
    func root(viewController: UIViewController, animate: Bool = true) {
        screen.root.accept((viewController, animate))
    }
    
    func add(viewController: UIViewController) {
        screen.add.accept(viewController)
    }
    
    func remove(viewController: UIViewController) {
        screen.remove.accept(viewController)
    }
    
    func remove<T>(type: T) {
        let targetName = String(describing: type)
        screen.removeName.accept(targetName)
    }
    
    func unwind(identifier: String) {
        screen.unwind.accept(identifier)
    }
}

