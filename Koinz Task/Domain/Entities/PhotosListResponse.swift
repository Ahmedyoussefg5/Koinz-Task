//
//  PhotosListResponse.swift
//  Koinz Task
//
//  Created by Youssef on 14/07/2023.
//

import Foundation

struct PhotosListResponse: Codable {
    let photos: FlickrPhotos?
    let stat: String
    let message: String?
}

struct FlickrPhotos: Codable {
    let page, pages, perpage, total: Int?
    let photo: [FlickrPhoto]?
}

struct FlickrPhoto: Codable {
    let id, owner, secret, server: String
    let farm: Int
    let title: String
}
