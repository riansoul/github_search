//
//  NetworkModel.swift
//  github_search
//
//  Created by jy choi on 2022/03/07.
//

import Foundation

protocol BaseResponse: Codable {
    var count             : Int { get }
    var results           : Bool { get }
    var items             : [item] { get }
}

struct Response: BaseResponse {
    private(set) var count        : Int
    private(set) var results      : Bool
    private(set) var items        : [item]
    
    private enum CodingKeys: String, CodingKey {
        case count = "total_count"
        case results = "incomplete_results"
        case items
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        count    = (try? container.decode(Int.self, forKey: .count)) ?? 0
        results  = (try? container.decode(Bool.self, forKey: .results)) ?? false
        items    = (try? container.decode([item].self, forKey: .items)) ?? []
    }
}

struct item: Codable {
    private(set) var id                 : Int?
    private(set) var node_id            : String?
    private(set) var name               : String?
    private(set) var full_name          : String?
    private(set) var privateFlag        : Bool?
    private(set) var description        : String?
    private(set) var updated_at         : String?
    private(set) var pushed_at          : String?
    
    private(set) var html_url           : String?
    private(set) var stargazers_count   : Int?
    private(set) var language           : String?
    private(set) var topics             : [String]?
    private(set) var license            : licenseData?
    
    private enum CodingKeys: String, CodingKey {
        case id, node_id
        case name,full_name
        case privateFlag  = "private"
        case description, updated_at, pushed_at
        case html_url, stargazers_count, language
        case topics, license
    }
    
    init(from decoder: Decoder) throws {
        let container       = try decoder.container(keyedBy: CodingKeys.self)
        id                  = (try? container.decode(Int.self, forKey: .id)) ?? 0
        node_id             = (try? container.decode(String.self, forKey: .node_id)) ?? ""
        name                = (try? container.decode(String.self, forKey: .name)) ?? ""
        full_name           = (try? container.decode(String.self, forKey: .full_name)) ?? ""
        privateFlag         = (try? container.decode(Bool.self, forKey: .privateFlag)) ?? false
        description         = (try? container.decode(String.self, forKey: .description)) ?? ""
        updated_at          = (try? container.decode(String.self, forKey: .updated_at)) ?? ""
        pushed_at           = (try? container.decode(String.self, forKey: .pushed_at)) ?? ""
        html_url            = (try? container.decode(String.self, forKey: .html_url)) ?? ""
        stargazers_count    = (try? container.decode(Int.self, forKey: .stargazers_count)) ?? 0
        language            = (try? container.decode(String.self, forKey: .language)) ?? ""
        topics              = (try? container.decode([String].self, forKey: .topics)) ?? []
        license             = (try? container.decode(licenseData.self, forKey: .license)) ?? nil
    }
}

struct licenseData: Codable {
    
    private(set) var key          : String?
    private(set) var name         : String?
    private(set) var spdx_id      : String?
    private(set) var url          : String?
    private(set) var node_id      : String?
    
    
    private enum CodingKeys: String, CodingKey {
        case key
        case name
        case spdx_id
        case url
        case node_id
    }
    
    init(from decoder: Decoder) throws {
        let container   = try decoder.container(keyedBy: CodingKeys.self)
        key             = (try? container.decode(String.self, forKey: .key)) ?? ""
        name            = (try? container.decode(String.self, forKey: .name)) ?? ""
        spdx_id         = (try? container.decode(String.self, forKey: .spdx_id)) ?? ""
        url             = (try? container.decode(String.self, forKey: .url)) ?? ""
        node_id         = (try? container.decode(String.self, forKey: .node_id)) ?? ""
    }
}
