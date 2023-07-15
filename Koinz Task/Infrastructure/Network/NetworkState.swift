//
//  NetworkState.swift
//  Koinz Task
//
//  Created by Youssef on 14/07/2023.
//

import Foundation

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
}
