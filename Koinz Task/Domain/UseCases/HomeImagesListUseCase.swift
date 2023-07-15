//
//  HomeImagesListUseCase.swift
//  Koinz Task
//
//  Created by Youssef on 15/07/2023.
//

import Foundation

protocol HomeImagesListUseCase {
    func execute(page: Int) async -> ScreenState<FlickrPictureUIModel>
}

class HomeImagesListUseCaseImp: HomeImagesListUseCase {
    
    init(moviesRepository: HomeRepository) {
        self.moviesRepository = moviesRepository
    }
    
    private let moviesRepository: HomeRepository
    
    func execute(page: Int) async -> ScreenState<FlickrPictureUIModel> {
        
        let result = await moviesRepository
            .fetchImagesList(body: .init(page: page))
        
        switch result {
        case .success(let model):
            let imageList = (model?.photos?.photo ?? []).map({ FlickrPictureModel(model: $0) })
            let flickrPictureUIModel = FlickrPictureUIModel(currentPage: page, lastPage: model?.photos?.pages ?? 0, images: imageList)
            return .success(flickrPictureUIModel)
        case .fail(let error):
            return .failure(error.errorAssociatedMessage)
        }
    }
}
