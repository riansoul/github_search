//
//  ViewModelTypeProtocol.swift
//  github_search
//
//  Created by jy choi on 2022/03/07.
//

import Foundation

protocol ViewModelTypeProtocol {
    
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
