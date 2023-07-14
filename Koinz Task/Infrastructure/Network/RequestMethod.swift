//
//  RequestMethod.swift
//  Koinz Task
//
//  Created by Youssef on 14/07/2023.
//

import Foundation
import Alamofire
import SwiftUI

@propertyWrapper
struct GET<T: Codable> {
    
    var wrappedValue: any Network<T> {
        mutating get {
            return request
        }
    }
    
    private var request: any Network<T>

    init(url: RequestUrl, encoding: RequestEncodingType = .json) {
        request = NetworkRequest<T>(request: AppURLRequest(url: url, method: .get, encoding: encoding))
    }
}

@propertyWrapper
struct POST<T: Codable> {
    
    var wrappedValue: any Network<T> {
        mutating get {
            return request
        }
    }
    
    private var request: any Network<T>

    init(url: RequestUrl, encoding: RequestEncodingType = .json) {
        request = NetworkRequest<T>(request: AppURLRequest(url: url, method: .post, encoding: encoding))
    }
}
