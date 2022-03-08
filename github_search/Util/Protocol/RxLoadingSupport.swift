//
//  RxLoadingSupport.swift
//  github_search
//
//  Created by jy choi on 2022/03/08.
//

import Foundation

import RxCocoa
import RxSwift

struct RxLoadingSupportData {
    
    var show = BehaviorRelay<Bool>(value: false)
}

protocol RxLoadingSupport {

    var loading: RxLoadingSupportData { get }
}

extension RxLoadingSupport {
    
    func showLoading() {
        loading.show.accept(true)
    }
    
    func hideLoading() {
        loading.show.accept(false)
    }
    
}
