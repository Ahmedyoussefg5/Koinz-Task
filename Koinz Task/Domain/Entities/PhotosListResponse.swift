//
//  PhotosListResponse.swift
//  Koinz Task
//
//  Created by Youssef on 14/07/2023.
//

import Foundation

struct PhotosListResponse: Codable {
    let photos: Photos?
    let stat: String
}

struct Photos: Codable {
    let page, pages, perpage, total: Int?
    let photo: [Photo]?
}

struct Photo: Codable {
    let id, owner, secret, server: String?
    let farm: Int?
    let title: String?
    let ispublic, isfriend, isfamily: Int?
}
