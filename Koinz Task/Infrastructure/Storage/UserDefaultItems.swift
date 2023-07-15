//
//  UserDefaultItems.swift
//  Koinz Task
//
//  Created by Youssef on 15/07/2023.
//

import Foundation

extension UserDefaults {
    @UserDefault(key: "HomeResponse", defaultValue: nil)
    static var photosList: [PhotosListResponse]?
}
