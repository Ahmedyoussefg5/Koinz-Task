//
//  ImageListBody.swift
//  Koinz Task
//
//  Created by Youssef on 14/07/2023.
//

import Foundation

struct ImageListBody: JsonEncadable {
    init(page: Int) {
        self.page = page
    }
    
    let method = "flickr.photos.search"
    let format = "json"
    let text = "Color"
    let page: Int
    let per_page = 20
    let api_key = Constants.apiKey
    let nojsoncallback = 1
}
