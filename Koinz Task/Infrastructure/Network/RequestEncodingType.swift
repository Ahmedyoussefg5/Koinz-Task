//
//  RequestEncodingType.swift
//  Koinz Task
//
//  Created by Youssef on 14/07/2023.
//

import Foundation
import Alamofire

enum RequestEncodingType {
    case json
    case url
    
    var value: ParameterEncoding {
        switch self {
        case .json:
           return JSONEncoding.default
        case .url:
            return URLEncoding.default
        }
    }
}
