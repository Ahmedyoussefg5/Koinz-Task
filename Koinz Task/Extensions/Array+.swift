//
//  Array+.swift
//  Koinz Task
//
//  Created by Youssef on 15/07/2023.
//

import Foundation

extension Array {
    func chunk(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}
