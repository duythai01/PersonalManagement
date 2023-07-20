//
//  SettingCoordinator.swift
//  PersonalManagement
//
//  Created by DuyThai on 08/05/2023.
//

import Foundation

struct SettingCoordinator {
    var navigationController: BaseNavigationController
    func start() {
        let viewController = SettingViewController()
        let viewModel = SettingViewModel(coordinator: self)
        viewController.viewModel = viewModel
        navigationController.pushViewController(viewController, animated: true)
    }
}
