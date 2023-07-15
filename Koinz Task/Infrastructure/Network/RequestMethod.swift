//
//  RequestMethod.swift
//  Koinz Task
//
//  Created by Youssef on 14/07/2023.
//

import Foundation

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
