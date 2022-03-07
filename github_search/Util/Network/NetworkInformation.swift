//
//  NetworkInformation.swift
//  github_search
//
//  Created by Geondae Baek on 2022/03/07.
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
    
    private static var api_url: String {
        return "https://api.github.com/search/repositories"
    }
    
    public static var api: String {
        return "\(ServerSetting.api_url)"
    }
}
