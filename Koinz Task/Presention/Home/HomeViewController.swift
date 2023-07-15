//
//  HomeViewController.swift
//  Koinz Task
//
//  Created by Youssef on 14/07/2023.
//

import UIKit
import NVActivityIndicatorView

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    lazy var activityIndicatorView = NVActivityIndicatorView(frame: .init(x: 0, y: 0, width: 80, height: 80), type: .ballClipRotate, color: .systemBlue, padding: .zero)
    
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
        tableView.register(.init(nibName: "ImageTableViewCell", bundle: .main), forCellReuseIdentifier: "ImageTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
        sink()
        getImages()
    }
    
    private func sink() {
        viewModel.$state
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
    
    func startLoading() {
        view.addSubview(activityIndicatorView)
        activityIndicatorView.center = view.center
        activityIndicatorView.startAnimating()
    }
    
    func stopLoading() {
        activityIndicatorView.removeFromSuperview()
        activityIndicatorView.stopAnimating()
    }
    
    func showAlert(with message: String) {
        print(message)
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.imagesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ImageTableViewCell") as! ImageTableViewCell
        cell.config(model: viewModel.imagesList[indexPath.row])
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if ((scrollView.contentOffset.y + scrollView.frame.size.height) > scrollView.contentSize.height) {
            getImages()
        }
    }
}
