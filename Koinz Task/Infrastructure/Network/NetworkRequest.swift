//
//  NetworkRequest.swift
//  Koinz Task
//
//  Created by Youssef on 14/07/2023.
//

import Foundation
import Alamofire
import Combine

typealias RequestPublisher<T: Codable> = AnyPublisher<NetworkState<T>, Never>

protocol Network<T>: AnyObject {
    associatedtype T: Codable
    var request: RequestReusable { get }
    func asPublisher() -> RequestPublisher<T>
    func withBody(_ body: JsonEncadable?) -> Self
}

class NetworkRequest<T: Codable>: Network {
    
    var request: RequestReusable
    
    private lazy var interceptor = AppRequestInterceptor()
        
    init(request: RequestReusable) {
        self.request = request
    }
    
    private lazy var sessionManager: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForResource = 60
        configuration.timeoutIntervalForRequest = 60
        return Session(configuration: configuration, interceptor: interceptor)
    }()
    
    func withBody(_ body: JsonEncadable?) -> Self {
        request.body = body
        return self
    }
    
    @discardableResult
    func asPublisher() -> RequestPublisher<T> {
        sessionManager
            .request(request)
            .publishDecodable()
            .map({ NetworkState($0) })
            .eraseToAnyPublisher()
    }
}
