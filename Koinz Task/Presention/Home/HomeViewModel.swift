//
//  HomeViewModel.swift
//  Koinz Task
//
//  Created by Youssef on 15/07/2023.
//

import Foundation

class HomeViewModel {
    
    @Published var state : ScreenState<Void> = .ideal
    
    var imagesList: [FlickrPictureModel] = []
    private var lastPage = 1
    private var currentPage = 0
    
    private var bag = AppBag()
    
    let useCase: HomeImagesListUseCase
    
    
    init(useCase: HomeImagesListUseCase) {        
        self.useCase = useCase
    }
    
    func fetchImages() async {
        guard state != .loading else { return }
        guard lastPage >= currentPage else { return }
        
        state = .loading
        
        let newResultState = await useCase.execute(page: currentPage + 1)
        
        if let newModel = newResultState.data {
            lastPage = newModel.lastPage
            currentPage = newModel.currentPage
            imagesList.append(contentsOf: newModel.images)
            state = .success(())
        }
    }
}
