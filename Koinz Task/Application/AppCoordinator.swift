//
//  AppCoordinator.swift
//  Koinz Task
//
//  Created by Youssef on 14/07/2023.
//

import UIKit

class AppCoordinator {

    var navigationController: UINavigationController
    
    init(
        navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        navigationController.viewControllers = [HomeViewController.create()]
    }
}
