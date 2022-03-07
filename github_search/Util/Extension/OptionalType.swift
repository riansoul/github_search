//
//  OptionalType.swift
//  github_search
//
//  Created by jy choi on 2022/03/06.
//

import Foundation

protocol OptionalType {
    associatedtype Wrapped
    var optional: Wrapped? { get }
}

extension Optional: OptionalType {
    var optional: Wrapped? {
        return self
    }
}
