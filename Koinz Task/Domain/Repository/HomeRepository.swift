//
//  HomeRepository.swift
//  Koinz Task
//
//  Created by Youssef on 14/07/2023.
//

import Foundation

protocol HomeRepository {
    func fetchImagesList(body: ImageListBody) async -> NetworkState<PhotosListResponse>
}
