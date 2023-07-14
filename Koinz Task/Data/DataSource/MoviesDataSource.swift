//
//  MoviesDataSource.swift
//  Koinz Task
//
//  Created by Youssef on 14/07/2023.
//

import Foundation

protocol HomeImagesDataSource {
    var getHomeImages: any RequestMaker<PhotosListResponse> { get }
}

class ImagesListRequest: RequestMaker {
    typealias T = PhotosListResponse

    @GET<T>(url: .path(""), encoding: .url)
    var network: any Network<T>
}

class HomeImagesDataSourceImp: HomeImagesDataSource {
    let getHomeImages: any RequestMaker<PhotosListResponse>
    
    init(getHomeImages: any RequestMaker<PhotosListResponse>) {
        self.getHomeImages = getHomeImages
    }
}
