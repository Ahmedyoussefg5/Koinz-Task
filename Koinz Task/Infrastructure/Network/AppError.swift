//
//  AppNetworkError.swift
//  Koinz Task
//
//  Created by Youssef on 14/07/2023.
//

import Foundation

protocol AppError: LocalizedError {
    var validatorErrorAssociatedMessage: String { get }
}

enum AppNetworkError: AppError {
    
    case networkError
    case businessError(String)
    case basicError
    
     var validatorErrorAssociatedMessage: String {
        switch self {
        case .networkError:
            return "Network Error Message"
        case .businessError( let error):
            return error
        case .basicError:
            return "Something wrong happened, try again later."
        }
    }
}
