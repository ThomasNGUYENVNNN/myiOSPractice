//
//  LocalEnum.swift
//  SpeechToTextDemo
//
//  Created by SHUN on 12/19/16.
//  Copyright © 2016 q2650108. All rights reserved.
//

import Foundation

enum LocalEnum : String {
    case English = "en-US"
    case 中文 = "zh-Hant"
    case 日本語 = "ja-JP"
    
    
    
    /// String To Enum
    static func toLocalEnum( str : String ) -> LocalEnum {
        switch str {
        case "English" : return .English
        case "中文" : return .中文
        case "日本語" : return .日本語
        default :
            return .English
        }
    }
}

