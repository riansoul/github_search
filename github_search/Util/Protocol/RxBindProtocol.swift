//
//  RxBindProtocol.swift
//  github_search
//
//  Created by jy choi on 2022/03/07.
//

import UIKit
import RxSwift
import RxAppState


let protocolClass = ProtocolClass.init()

class ProtocolClass {
    public var classWindow   : UIWindow!
}

@objc protocol RxBindProtocol: AnyObject {

    @objc optional func bindInput()
    @objc optional func bindOutput()
}

extension RxBindProtocol where Self: UIViewController {
    
    func bindRx() {
        bindInput?()
        bindOutput?()
    }
    
    func bind<T>(_ viewModel: T, bag: DisposeBag) {
        
        if let viewModel = viewModel as? RxLoadingSupport, let loading = self as? LoadingProtocol {
         
            viewModel.loading.show
                .distinctUntilChanged()
                .observeOn(MainScheduler.instance)
                .bind{ show in
                    if show {
                        loading.showLoading()
                    } else {
                        loading.hideLoading()
                    }
                }.disposed(by: bag)
        }
        
        if let viewModel = viewModel as? RxAlertSupport {
            viewModel.alert.show
                .asDriver()
                .filterNil()
                .drive(onNext: { [weak self] data in
                    guard let `self` = self else { return }
                    self.showAlert(title: data.title, message: data.message, buttons: data.buttons)                    
                })
                .disposed(by: bag)
        }
        
        if let viewModel = viewModel as? RxScreenSupport {

            rx.viewWillAppear
                .single()
                .subscribe(onNext: { [weak self] _ in
                    guard let `self` = self else { return }
                    
                    viewModel.screen.show
                        .asDriver()
                        .filterNil()
                        .drive(onNext: { [weak self] data in
                            guard let `self` = self else { return }
                            
                            switch data.type {
                            case .present:
                                self.modalPresentationStyle = .overFullScreen
                                self.present(data.viewController, animated: data.animate, completion: { [weak self] in
                                    self?.setNeedsStatusBarAppearanceUpdate()
                                })
                            case .push:
                                let navigation = self.navigationController

                                if data.replace {
                                    navigation?.popViewController(animated: false)
                                }

                                navigation?.pushViewController(data.viewController, animated: data.animate)
                            }
                        })
                        .disposed(by: bag)
                    
                    viewModel.screen.hide
                        .asDriver()
                        .filterNil()
                        .drive(onNext: { [weak self] type, animate in
                            guard let `self` = self else { return }
                            
                            switch type {
                            case .pop:
                                self.navigationController?.popViewController(animated: animate)
                            case .dismiss:
                                self.dismiss(animated: animate, completion: { [weak self] in
                                    self?.setNeedsStatusBarAppearanceUpdate()
                                })
                            case .back:
                                self.back()
                            }
                        })
                        .disposed(by: bag)
                    
                    viewModel.screen.dismiss
                        .asDriver()
                        .filterNil()
                        .drive(onNext: { [weak self] targetName in
                            guard let `self` = self else { return }
                            
                            if let presented = self.presentedViewController, String(describing: type(of: presented)) == targetName {
                                self.presentedViewController?.dismiss(animated: true, completion: nil)
                            }
                        })
                        .disposed(by: bag)
                })
                .disposed(by: bag)
            
            viewModel.screen.root
                .asDriver()
                .filterNil()
                .drive(onNext: { data in
                    UIApplication.shared.keyWindow?.rootViewController(data.viewController, animate: data.animate)
                })
                .disposed(by: bag)
            
            viewModel.screen.add
                .asDriver()
                .filterNil()
                .drive(onNext: { [weak self] viewController in
                    self?.addChild(viewController: viewController)
                })
                .disposed(by: bag)
            
            viewModel.screen.remove
                .asDriver()
                .filterNil()
                .drive(onNext: { [weak self] viewController in
                    self?.removeChild(viewController: viewController)
                })
                .disposed(by: bag)
            
            viewModel.screen.removeName
                .asDriver()
                .filterNil()
                .drive(onNext: { [weak self] targetName in
                    guard let `self` = self else { return }
                    
                    self.children.forEach { [weak self] viewController in
                        guard let `self` = self else { return }
                        
                        let viewControllerName = String(describing: type(of: viewController))
                        if  viewControllerName == targetName {
                            self.removeChild(viewController: viewController)
                        }
                    }
                })
                .disposed(by: bag)
            
            viewModel.screen.unwind
                .asDriver()
                .filterNil()
                .drive(onNext: { [weak self] identifier in
                    self?.performSegue(withIdentifier: identifier, sender: self)
                })
                .disposed(by: bag)
        }
    }
}

