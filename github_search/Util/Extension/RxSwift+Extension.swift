//
//  RxSwift+Extension.swift
//  github_search
//
//  Created by jy choi on 2022/03/06.
//

import Foundation
import RxCocoa
import RxSwift

// MARK: - BehaviorRelay
extension BehaviorRelay where Element == Bool {
    
    func filterTrue() -> Observable<Void> {
        return filter { $0 }.map { _ in () }
    }
    
    func filterFalse() -> Observable<Void> {
        return filter { !$0 }.map { _ in () }
    }
}

// MARK: -
extension BehaviorRelay where Element: OptionalType {
    
    func filterNil() -> Observable<Element.Wrapped> {
        return filter { $0.optional != nil }.map { $0.optional! }
    }
}

// MARK: -

extension BehaviorRelay where Element == Void {
    
    func acceptVoid() {
        accept(())
    }
}

// MARK: - PublishRelay

extension PublishRelay where Element == Void {
    
    func acceptVoid() {
        accept(())
    }
}

// MARK: - Observable

extension Observable where Element == Bool {
    
    func filterTrue() -> Observable<Void> {
        return filter { $0 }.map { _ in () }
    }
    
    func filterFalse() -> Observable<Void> {
        return filter { !$0 }.map { _ in () }
    }
}

extension Observable where Element: OptionalType {
    
    func filterNil() -> Observable<Element.Wrapped> {
        return filter { $0.optional != nil }.map { $0.optional! }
    }
}

extension Observable {
    
    func withPrevious(start: E) -> Observable<(E, E)> {
        return scan((start, start)) { ($0.1, $1) }
    }
    
    func catchErrorJustEmpty() -> Observable<E> {
        return catchError { _ in
            return Observable.empty()
        }
    }
    
    func asDriverJustEmpty() -> Driver<E> {
        return asDriver { error in
            return Driver.empty()
        }
    }
    
    func mapToVoid() -> Observable<Void> {
        return map { _ in }
    }
}

// MARK: -

extension SharedSequenceConvertibleType where E == Bool {
    
    func filterTrue() -> SharedSequence<SharingStrategy, Void> {
        return filter { $0 }.map { _ in () }
    }
}

extension SharedSequenceConvertibleType where E: OptionalType {
    
    func filterNil() -> SharedSequence<SharingStrategy, E.Wrapped> {
        return filter { $0.optional != nil }.map { $0.optional! }
    }
}

extension SharedSequenceConvertibleType {
    
    func withPrevious(start: E) -> SharedSequence<SharingStrategy, (E, E)> {
        return scan((start, start)) { ($0.1, $1) }
    }
}
