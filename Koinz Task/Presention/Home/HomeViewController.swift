//
//  HomeViewController.swift
//  Koinz Task
//
//  Created by Youssef on 14/07/2023.
//

import UIKit
import NVActivityIndicatorView

class HomeViewController: UIViewController, LoadingViewCapable {
    
    @IBOutlet private weak var tableView: UITableView!
    
    private let viewModel: HomeViewModel
    
    private var bag = AppBag()
    
    class func create() -> UIViewController {
        let dataSource = HomeImagesDataSourceImp(getHomeImages: ImagesListRequest())
        let cache = HomeImageListResponseStorageImp()
        let repo: HomeRepository = HomeRepositoryImp(dataSource: dataSource, cache: cache)
        let useCase = HomeImagesListUseCaseImp(moviesRepository: repo)
        let viewModel = HomeViewModel(useCase: useCase)
        return HomeViewController(viewModel: viewModel)
    }
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        sink()
        getImages()
    }
    
    private func setupTableView() {
        tableView.registerCellNib(cellClass: ImageTableViewCell.self)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func sink() {
        viewModel.$state
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .sink {[weak self] state in
                switch state {
                case .ideal:
                    self?.stopLoading()
                case .loading:
                    self?.startLoading()
                case .success(_):
                    self?.stopLoading()
                    self?.tableView.reloadData()
                case .successWith:
                    self?.stopLoading()
                case .failure(let error):
                    self?.showAlert(with: error)
                }
            }.store(in: &bag)
    }
    
    private func getImages() {
        Task {
            await viewModel.fetchImages()
        }
    }
    
    func showAlert(with message: String) {
        print(message)
    }
}

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.imagesList.count - 3 {
            Task {
                await viewModel.fetchImages()
            }
        }
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.imagesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(ImageTableViewCell.self)
        cell.config(model: viewModel.imagesList[indexPath.row])
        return cell
    }
}
