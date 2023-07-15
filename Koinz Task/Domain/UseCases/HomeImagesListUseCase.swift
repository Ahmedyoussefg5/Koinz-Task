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
            let sep = FlickrPictureModel(imageName: "youtube ad")
            
            let newItems = (0 ..< 5 * imageList.count - 5).map { $0 % 2 == 0 ? imageList[$0/5] : sep }
            
            let flickrPictureUIModel = FlickrPictureUIModel(currentPage: model?.photos?.page ?? 0, lastPage: model?.photos?.pages ?? 0, images: newItems)
            return .success(flickrPictureUIModel)
        case .fail(let error):
            return .failure(error.errorAssociatedMessage)
        }
    }
}
