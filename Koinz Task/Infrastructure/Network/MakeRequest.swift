//
//  MakeRequest.swift
//  Koinz Task
//
//  Created by Youssef on 14/07/2023.
//

import Foundation

protocol RequestMaker<T>: AnyObject {
    associatedtype T: Codable
    var network: any Network<T> { get }
    func addPathVariables(path: String...) -> Self
    func makeRequest(with body: JsonEncadable?) -> RequestPublisher<T>
}

extension RequestMaker {
    func makeRequest(with body: JsonEncadable? = nil) -> RequestPublisher<T> {
        network
            .withBody(body)
            .asPublisher()
    }
    
    func addPathVariables(path: String...) -> Self {
        network.request.addPathVariables(path: path)
        return self
    }
}
