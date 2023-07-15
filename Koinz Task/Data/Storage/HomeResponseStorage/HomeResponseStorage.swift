//
//  HomeResponseStorage.swift
//  Koinz Task
//
//  Created by Youssef on 14/07/2023.
//

import Foundation

protocol HomeImageListResponseStorage {
    func getResponse(page: Int) -> PhotosListResponse?
    func save(response: PhotosListResponse)
}

final class HomeImageListResponseStorageImp: HomeImageListResponseStorage {
    
    func getResponse(page: Int) -> PhotosListResponse? {
        (UserDefaults.photosList ?? []).first(where: { $0.photos?.page == page })
    }
    
    func save(response: PhotosListResponse) {
        var oldValue = UserDefaults.photosList ?? []
        oldValue.append(response)
        UserDefaults.photosList = oldValue
    }
}
