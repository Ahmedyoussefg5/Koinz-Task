//
//  RequestUrl.swift
//  Koinz Task
//
//  Created by Youssef on 14/07/2023.
//

import Foundation

enum RequestUrl {
    case full(String)
    case path(String)
    
    var value: String {
        switch self {
        case .full(let url):
            return url
        case.path(let path):
            return Constants.baseUrl + path
        }
    }
}
