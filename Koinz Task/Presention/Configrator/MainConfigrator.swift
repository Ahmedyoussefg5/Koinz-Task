//
//  MainConfigrator1.swift
//  Koinz Task
//
//  Created by Youssef on 15/07/2023.
//

import UIKit

enum MainConfigurator {
    
    static func getHomeView() -> UIViewController {
        let dataSource = HomeImagesDataSourceImp(getHomeImages: ImagesListRequest())
        let cache = HomeImageListResponseStorageImp()
        let repo: HomeRepository = HomeRepositoryImp(dataSource: dataSource, cache: cache)
        let useCase = HomeImagesListUseCaseImp(moviesRepository: repo)
        let viewModel = HomeViewModel(useCase: useCase)
        return HomeViewController(viewModel: viewModel)
    }
}
