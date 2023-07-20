//
//  NotificationCoordinator.swift
//  PersonalManagement
//
//  Created by DuyThai on 08/05/2023.
//

import Foundation

struct NotificationCoordinator {
    var navigationController: BaseNavigationController
    func start() {
        let viewController = NotificationViewController()
        let viewModel = NotificationViewModel(coordinator: self)
        viewController.viewModel = viewModel
        navigationController.pushViewController(viewController, animated: true)
    }
}
