//
//  KurlyAPI.swift
//  github_search
//
//  Created by jy choi on 2022/03/07.
//

import Foundation

struct KurlyAPI {
    static let shared = KurlyAPI()
    let networkManager = NetworkManager()
}
