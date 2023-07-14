//
//  HomeViewController.swift
//  Koinz Task
//
//  Created by Youssef on 14/07/2023.
//

import UIKit

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        
        let dataSource = HomeImagesDataSourceImp(getHomeImages: ImagesListRequest())
        let cache = HomeImageListResponseStorageImp()
        let repo: HomeRepository = HomeRepositoryImp(dataSource: dataSource, cache: cache)
        
        let body = ImageListBody(page: 1)
        
        Task {
           await repo.fetchImagesList(body: body)
        }
        
    }
}
