//
//  LoginCoordinator.swift
//  PersonalManagement
//
//  Created by DuyThai on 07/05/2023.
//

import Foundation

struct LoginCoordinator {
    var navigationController: BaseNavigationController
    func start() {
        let viewController = LoginViewController()
        let viewModel = LoginViewModel(coordinator: self)
        viewController.viewModel = viewModel
        navigationController.pushViewController(viewController, animated: true)
    }

    func goToMainTabBar() {
        let mainTabBarCooridnator = MainTabBarCoordinator(navigationController: navigationController)
        mainTabBarCooridnator.toMainTabBar()
    }

}
