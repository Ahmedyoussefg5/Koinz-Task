//
//  HomeImagesListUseCase.swift
//  Koinz Task
//
//  Created by Youssef on 15/07/2023.
//

import Combine

protocol HomeImagesListUseCase {
    func execute(page: Int) async -> ScreenState<FlickrPictureUIModel>
}

final class HomeImagesListUseCaseImp: HomeImagesListUseCase {
    
    private let moviesRepository: HomeRepository
    
    init(moviesRepository: HomeRepository) {
        self.moviesRepository = moviesRepository
    }
    
    private func handle(_ result: NetworkState<PhotosListResponse>) -> ScreenState<FlickrPictureUIModel> {
        switch result {
        case .success(let model):
            if let model, model.stat == "ok" {
                let imageList = (model.photos?.photo ?? []).map({ FlickrPictureModel(model: $0) })
                let flickrPictureUIModel = FlickrPictureUIModel(currentPage: model.photos?.page ?? 0, lastPage: model.photos?.pages ?? 0, images: handleAddingAdImagesIn(resultArray: imageList))
                return .success(flickrPictureUIModel)
            } else {
                return .failure(model?.message ?? AppNetworkError.networkError.errorAssociatedMessage)
            }
        case .fail(let error):
            return .failure(error.errorAssociatedMessage)
        }
    }
    
    private func handleAddingAdImagesIn(resultArray: [FlickrPictureModel]) -> [FlickrPictureModel] {
        let adImage = FlickrPictureModel(imageName: "youtube ad")
        
        let chunks = resultArray.chunk(into: 5)
        
        var newItems = Array(chunks.joined(separator: [adImage]))
        newItems.append(adImage)
        
        return newItems
    }
    
    func execute(page: Int) async -> ScreenState<FlickrPictureUIModel> {
        let result = await moviesRepository
            .fetchImagesList(body: .init(page: page))
        return handle(result)
    }
}
