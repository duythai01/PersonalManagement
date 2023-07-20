//
//  HomeCoordinator.swift
//  PersonalManagement
//
//  Created by DuyThai on 08/05/2023.
//

import Foundation

struct HomeCoordinator {
    var navigationController: BaseNavigationController
    func start() {
        let viewController = HomeViewController()
        let viewModel = HomeViewModel(coordinator: self)
        viewController.viewModel = viewModel
        navigationController.pushViewController(viewController, animated: true)
    }
}

