//
//  AppURLRequest.swift
//  Koinz Task
//
//  Created by Youssef on 14/07/2023.
//

import Foundation
import Alamofire
import Combine

protocol RequestReusable: Alamofire.URLRequestConvertible, AnyObject {
    var body: JsonEncadable? { get set }
}

class AppURLRequest: RequestReusable {
    
    init(url: RequestUrl, method: HTTPMethod, encoding: RequestEncodingType = .json) {
        self.urlReq = url
        self.method = method
        self.encoding = encoding
    }
    
    var body: JsonEncadable?
    
    private let urlReq: RequestUrl
    private let method: HTTPMethod
    private let encoding: RequestEncodingType
    
    func asURLRequest() throws -> URLRequest {
        let urlString = urlReq.value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        print(urlString)
        let url = URL(string: urlString)!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        return try encoding.value.encode(urlRequest, with: body?.json)
    }
}
