//
//  GitHubAPI.swift
//  github_search
//
//  Created by jy choi on 2022/03/07.
//

import Foundation
import RxCocoa
import RxSwift

extension KurlyAPI {
    
    func getSearchListInfo(param:searchParam) -> Observable<Response> {
        
        let params : [String:Any]? = ["search" :  param.search,
                                      "page"   :  param.page]
        
        let api = ServerSetting.api
        
        return networkManager.request(api: api, params: params, debug: true).mapObject(type: Response.self)
    }
}


