//
//  NetworkInformation.swift
//  github_search
//
//  Created by jy choi on 2022/03/07.
//

import Foundation

struct ServerSetting {

    public static var logEnable: Bool {
        #if DEBUG
        return true
        #else
        return false
        #endif
    }
    
    private static var apiUrl: String {
        return "https://api.github.com/search/repositories"
    }
    
    public static var api: String {
        return "\(ServerSetting.apiUrl)"
    }
}
