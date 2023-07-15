//
//  NetworkRequest.swift
//  Koinz Task
//
//  Created by Youssef on 14/07/2023.
//

import Foundation

protocol Network<T>: AnyObject {
    associatedtype T: Codable
    func execute() async -> NetworkState<T>
    func withBody(_ body: JsonEncadable?) -> Self
}

class NetworkRequest<T: Codable>: Network {
    
    var request: RequestReusable
            
    init(request: RequestReusable) {
        self.request = request
    }
    
    func withBody(_ body: JsonEncadable?) -> Self {
        request.body = body
        return self
    }
    
    @discardableResult
    func execute() async -> NetworkState<T> {
        do {
            let (data, _) = try await URLSession.shared.data(for: try! request.asURLRequest())
            let model = try JSONDecoder().decode (T.self, from: data)
            return .success(model)
        } catch {
            return .fail(AppNetworkError.networkError)
        }
    }
}
