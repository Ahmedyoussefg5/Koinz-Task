//
//  NetworkState.swift
//  Koinz Task
//
//  Created by Youssef on 14/07/2023.
//

import Alamofire

enum NetworkState<T: Codable> {
    case success(T?)
    case fail(AppError)
    
    var error: AppError? {
        switch self {
        case .fail(let error):
            return error
        default: return nil
        }
    }
    
    var data: T? {
        switch self {
        case .success(let data):
            return data
        default: return nil
        }
    }
    
    init(_ response: DataResponse<T, AFError>) {
        switch response.result {
        case .success(let model):
            self = .success(model)
            
        case .failure(let error):
#if DEBUG
            debugPrint("Model Name: \(String(describing: T.self)) has request error", error.asAFError?.errorDescription ?? "", error.localizedDescription, error.failureReason ?? "", error.localizedDescription, "With URL: ", response.request?.url?.absoluteString ?? "")
#endif
            self = .fail(AppNetworkError.networkError)
        }
    }
}
