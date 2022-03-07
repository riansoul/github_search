//
//  NetworkError.swift
//  github_search
//
//  Created by jy choi on 2022/03/07.
//

import Foundation

enum NetworkError: LocalizedError {
    
    case unknown                                  // 알수 없는 에러
    case network                                  // 네트워크 미연결
    case timeOut                                  // 타임아웃
    case statusCode(code: Int)                    // status != 200
    case parsing                                  // 파싱에러가 발생
    case responseFail(code: String, message: String) // fail code
    
    case requiredParam(cause: [String])           // 파라메터가 없음
    
    var errorDescription: String? {
        switch self {
        case .unknown :
            return "알수없는 오류가 발생하였습니다."
        case .network :
            return "네트워크 오류가 발생하였습니다."
        case .parsing :
            return "네트워크 오류가 발생하였습니다."
        case .statusCode(let code) :
            return "\("네트워크 오류가 발생하였습니다.")\n(\(code))"
        case .timeOut :
            return "요청한 시간을 초과하였습니다."
        case .responseFail(_, let message) :
            if message.isEmpty {
                return "네트워크 오류가 발생하였습니다."
            } else {
                return message
            }
        case .requiredParam(let cause) :
            return "\("필수 파라메터가 누락되었습니다.") : \(cause)"
        }
    }
}
