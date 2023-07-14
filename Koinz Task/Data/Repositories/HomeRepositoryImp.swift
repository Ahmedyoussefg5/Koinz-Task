//
//  HomeRepositoryImp.swift
//  Koinz Task
//
//  Created by Youssef on 14/07/2023.
//

import Combine

class HomeRepositoryImp: HomeRepository {
    
    init(dataSource: HomeImagesDataSource, cache: HomeImageListResponseStorage) {
        self.dataSource = dataSource
        self.cache = cache
    }
    
    private let dataSource: HomeImagesDataSource
    private let cache: HomeImageListResponseStorage
    
    private var bag = AppBag()
    
    func fetchImagesList(body: ImageListBody) async -> NetworkState<PhotosListResponse> {
        if let cachedResponse = cache.getResponse(page: body.page) {
            return .success(cachedResponse)
        }
        
        let state = await dataSource.getHomeImages.makeRequest(with: body)
            .singleOutput(with: &bag)
        
        if let responseData = state.data {
            cache.save(response: responseData, for: body.page)
        }
        
        return state
    }
}
