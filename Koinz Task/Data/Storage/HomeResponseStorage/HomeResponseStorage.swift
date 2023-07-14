//
//  HomeResponseStorage.swift
//  Koinz Task
//
//  Created by Youssef on 14/07/2023.
//

import Foundation

protocol HomeImageListResponseStorage {
    func getResponse(page: Int) -> PhotosListResponse?
    func save(response: PhotosListResponse, for page: Int)
}

class HomeImageListResponseStorageImp: HomeImageListResponseStorage {
    func getResponse(page: Int) -> PhotosListResponse? {
        return nil
    }

    func save(response: PhotosListResponse, for page: Int) {
        #warning("save")
    }
}
