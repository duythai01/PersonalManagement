//
//  StartedCoordinator.swift
//  PersonalManagement
//
//  Created by DuyThai on 06/05/2023.
//

import Foundation

struct StartedCoordinator {
    var navigationController: BaseNavigationController
    func start() {
        let viewController = StartedViewController()
        let viewModel = StartedViewModel(coordinator: self)
        viewController.viewModel = viewModel
        navigationController.pushViewController(viewController, animated: true)
    }

    func toLoginViewController() {
        let loginCoordinator = LoginCoordinator(navigationController: navigationController)
        loginCoordinator.start()
    }
}
