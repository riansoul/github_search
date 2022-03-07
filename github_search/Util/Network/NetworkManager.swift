//
//  NetworkManager.swift
//  github_search
//
//  Created by jy choi on 2022/03/07.
//

import Foundation
import Alamofire
import RxAlamofire
import RxCocoa
import RxSwift

final class NetworkManager {
    
    init(timeout: TimeInterval = 10) {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = timeout
        configuration.urlCache = nil
        configuration.allowsCellularAccess = true
        session = Alamofire.SessionManager(configuration: configuration)
    }
    
    fileprivate var session: SessionManager
    fileprivate lazy var disposeBag = DisposeBag()
    fileprivate lazy var networkScheduler = ConcurrentDispatchQueueScheduler(qos: .default)
}

extension NetworkManager {
    
    func request(_ httpMethod       : HTTPMethod = .get         ,
                 api                : String                    ,
                 params             : [String: Any]? = nil      ,
                 sessionFailRetry   : Bool = true               ,
                 debug              : Bool = ServerSetting.logEnable
        ) -> Observable<Any> {
        
        return work(httpMethod, api: api, params: params, codable: Response.self, debug: debug)
            .observeOn(networkScheduler)
            .catchError({ error -> Observable<Any> in
                 return Observable.error(error)
            })
    }
}

// MARK : - private function
extension NetworkManager {
    fileprivate func work<T: BaseResponse>(_ httpMethod : HTTPMethod = .post                ,
                                           api          : String                            ,
                                           params       : [String:Any]? = nil               ,
                                           codable      : T.Type                           ,
                                           debug        : Bool                              ,
                                           encoding     : ParameterEncoding = URLEncoding()
    )
    -> Observable<Any>
    {
        
        return session.rx.request(httpMethod, api, parameters: params, encoding: encoding)
            .do(onNext: { (request:DataRequest) in
                if debug {
                    let requestHeader = request.request?.allHTTPHeaderFields ?? [:]
                    let requestBody = request.request?.httpBody ?? Data()
                    let requestBodyString = String(data: requestBody, encoding: .utf8) ?? ""
                    
                    print(">>> Request URL : \(api)")
                    print("\n>>> Request Header : \(requestHeader)")
                    print("\n>>> Request Body : \(requestBodyString)")
                }
            })
                .flatMap{
                    $0.validate(statusCode: 200...200)
                        .rx
                        .json()
                }
                .do(onNext: { response in
                    if debug {
                        print(">>> Response URL : \(api)")
                        print("\n>>> Response Body :\n\(response)")
                    }
                }, onError: { error in
                    if debug {
                        print(">>> Response Error : \(error)")
                    }
                })
                    .catchError({ error -> Observable<Any> in
                        if (error as NSError).code == NSURLErrorTimedOut {
                            return Observable<Any>.error(NetworkError.timeOut)
                        }
                        
                        guard let alamofireError = error as? Alamofire.AFError else {
                            return Observable<Any>.error(NetworkError.network)
                        }
                        
                        if alamofireError.isResponseValidationError {
                            let code = alamofireError.responseCode ?? -1
                            return Observable<Any>.error(NetworkError.statusCode(code: code))
                        } else if alamofireError.isResponseSerializationError {
                            return Observable<Any>.error(NetworkError.parsing)
                        } else {
                            if (error as NSError).code == NSURLErrorTimedOut {
                                return Observable<Any>.error(NetworkError.timeOut)
                            } else {
                                return Observable<Any>.error(NetworkError.unknown)
                            }
                        }
                    })
                    .do(onNext: { response in
                        if let responseData = response as? NSDictionary {
                            let data = try JSONSerialization.data(withJSONObject: responseData, options: .prettyPrinted)
                            let decoder = JSONDecoder()
                            guard let _ = try? decoder.decode(codable.self, from: data) else {
                                throw NetworkError.parsing
                            }
                        }else {
                            throw NetworkError.responseFail(code: "", message: "")
                        }
                    })
                        }
}
