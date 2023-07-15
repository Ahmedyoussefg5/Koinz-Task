//
//  Publisher+.swift
//  Koinz Task
//
//  Created by Youssef on 14/07/2023.
//

import Foundation
import Combine

typealias AppBag = Set<AnyCancellable>

extension Publisher where Failure == Never {
    func singleOutput(with bag: inout Set<AnyCancellable>) async -> Output {
        return await withCheckedContinuation { continuation in
            sink(receiveValue: { value in
                continuation.resume(returning: value)
            }).store(in: &bag)
        }
    }
}
