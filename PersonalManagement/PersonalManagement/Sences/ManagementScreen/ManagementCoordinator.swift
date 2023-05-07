//
//  ManagementCoordinator.swift
//  PersonalManagement
//
//  Created by DuyThai on 08/05/2023.
//

import Foundation

struct ManagementCoordinator {
    var navigationController: BaseNavigationController
    func start() {
        let viewController = ManagementViewController()
        let viewModel = ManagementViewModel(coordinator: self)
        viewController.viewModel = viewModel
        navigationController.pushViewController(viewController, animated: true)
    }
}
