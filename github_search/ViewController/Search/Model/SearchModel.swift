//
//  SearchModel.swift
//  github_search
//
//  Created by jy choi on 2022/03/07.
//

import Foundation
import ObjectMapper


let listCellId      : String = "ListItem"
let TopicCellId     : String = "topicItemCell"

let hexBlackColor   : String = "ffffff"
let hexWhiteColor   : String = "ffffff"

let keyColor        : String = "color"

let textLengthError : String = "검색어를 입력해주세요."
let alertConfirm     : String = "확인"

let countText        : String = "총 %@개"

struct searchParam {
    var search     : String = "kurly"
    var page       : Int = 1
}

var languageColor  : NSDictionary = ["C"             : ["color" : "555555"],
                                     "C#"            : ["color" : "178600"],
                                     "C++"           : ["color" : "f34b7d"],
                                     "COBOL"         : ["color" : "000000"],
                                     "CoffeeScript"  : ["color" : "244776"],
                                     "CSS"           : ["color" : "563d7c"],
                                     "Dart"          : ["color" : "00B4AB"],
                                     "Go"            : ["color" : "00ADD8"],
                                     "HTML"          : ["color" : "e34c26"],
                                     "Java"          : ["color" : "b07219"],
                                     "JavaScript"    : ["color" : "f1e05a"],
                                     "JSON"          : ["color" : "292929"],
                                     "Kotlin"        : ["color" : "A97BFF"],
                                     "Objective-C"   : ["color" : "438eff"],
                                     "Perl"          : ["color" : "0298c3"],
                                     "PHP"           : ["color" : "4F5D95"],
                                     "Python"        : ["color" : "3572A5"],
                                     "Swift"         : ["color" : "F05138"],
                                     "TypeScript"    : ["color" : "2b7489"]]
