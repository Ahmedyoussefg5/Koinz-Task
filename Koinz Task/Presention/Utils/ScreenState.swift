//
//  ScreenState.swift
//  Koinz Task
//
//  Created by Youssef on 15/07/2023.
//

import Foundation
import Combine

typealias ScreenPublisher<T> = AnyPublisher<ScreenState<T>, Never>

enum ScreenState<T>: Equatable {
    static func == (lhs: ScreenState<T>, rhs: ScreenState<T>) -> Bool {
        switch (lhs, rhs) {
            
        case (.loading, .loading):
            return true
        case (.ideal, .ideal):
            return true
        case (.success, .success):
            return true
        case (.successWith, .successWith):
            return true
        case (.failure, .failure):
            return true
            
        default:
            return false
        }
    }
    
    
    case ideal
    case loading
    case success(T)
    case successWith(message: String)
    case failure(String)

    var data: T? {
        switch self {
        case .success(let value):
            return value
        default: return nil
        }
    }
    
    var error: String? {
        switch self {
        case .failure(let error):
            return error
        default: return nil
        }
    }
}
