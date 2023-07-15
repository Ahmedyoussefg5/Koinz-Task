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
    func makeRequest(with body: JsonEncadable?) async -> NetworkState<T>
}

extension RequestMaker {
    func makeRequest(with body: JsonEncadable? = nil) async -> NetworkState<T> {
        await network
            .withBody(body)
            .execute()
    }
}
