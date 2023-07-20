//
//  WalletCoordinator.swift
//  PersonalManagement
//
//  Created by DuyThai on 08/05/2023.
//

import Foundation

struct WalletCoordinator {
    var navigationController: BaseNavigationController
    func start() {
        let viewController = WalletViewController()
        let viewModel = WalletViewModel(coordinator: self)
        viewController.viewModel = viewModel
        navigationController.pushViewController(viewController, animated: true)
    }
}
