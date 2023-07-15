//
//  FlickrPictureUIModel.swift
//  Koinz Task
//
//  Created by Youssef on 15/07/2023.
//

import Foundation

struct FlickrPictureUIModel {
    let currentPage: Int
    let lastPage: Int
    let images: [FlickrPictureModel]
}

struct FlickrPictureModel {
    let image: FlickrPictureType
    
    init(model: FlickrPhoto) {
        image = .url("\(Constants.imageBaseUrl)\(model.server)/\(model.id)_\(model.secret).jpg")
    }
    
    init(imageName: String) {
        image = .imageName(imageName)
    }
}

enum FlickrPictureType {
    case url(String)
    case imageName(String)
}
