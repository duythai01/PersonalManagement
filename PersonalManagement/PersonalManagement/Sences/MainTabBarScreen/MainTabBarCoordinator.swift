//
//  MainTabBarCoordinator.swift
//  FlixHqMovie
//
//  Created by DuyThai on 08/03/2023.
//

import Foundation
import UIKit

struct MainTabBarCoordinator {
    var navigationController: BaseNavigationController

    init(navigationController: BaseNavigationController) {
        self.navigationController = navigationController
    }
    
    func toMainTabBar() {
        let tabBarController = MainTabBarViewController()
        tabBarController.viewControllers = [
            MoveToViewController().toWalletScreenViewController(),
            MoveToViewController().toManagementScreenViewController(),
            MoveToViewController().toHomeScreenViewController(),
            MoveToViewController().toNotificationScreenViewController(),
            MoveToViewController().toSettingViewController()
        ]
        navigationController.pushViewController(tabBarController, animated: true)
    }
    
}

struct MoveToViewController {
    func toHomeScreenViewController() -> BaseNavigationController {
        let homeNavigationController = BaseNavigationController()
        let homeCoordinator = HomeCoordinator(navigationController: homeNavigationController)
        homeCoordinator.start()
        homeNavigationController.tabBarItem = TabbarItem.home.item
        return homeNavigationController
    }

    func toWalletScreenViewController() -> BaseNavigationController {
        let walletNavigationController = BaseNavigationController()
        let walletCoordinator = WalletCoordinator(navigationController: walletNavigationController)
        walletCoordinator.start()
        walletNavigationController.tabBarItem = TabbarItem.wallet.item
        return walletNavigationController
    }

    func toSettingViewController() -> BaseNavigationController {
        let settingNavigationController = BaseNavigationController()
        let settingCoordinator = SettingCoordinator(navigationController: settingNavigationController)
        settingCoordinator.start()
        settingNavigationController.tabBarItem = TabbarItem.setting.item
        return settingNavigationController
    }

    func toNotificationScreenViewController() -> BaseNavigationController {
        let notificationNavigationController = BaseNavigationController()
        let notificationCoordinator = NotificationCoordinator(navigationController: notificationNavigationController)
        notificationCoordinator.start()
        notificationNavigationController.tabBarItem = TabbarItem.notification.item
        return notificationNavigationController
    }

    func toManagementScreenViewController() -> BaseNavigationController {
        let managementNavigationController = BaseNavigationController()
        let managementCoordinator = ManagementCoordinator(navigationController: managementNavigationController)
        managementCoordinator.start()
        managementNavigationController.tabBarItem = TabbarItem.management.item
        return managementNavigationController
    }
}

enum TabbarItem {
    case home
    case wallet
    case notification
    case management
    case setting

    var item: UITabBarItem {
        switch self {
        case .home:
            return UITabBarItem(title: "",
                                image: UIImage(systemName: "house.fill")?.withTintColor(.white, renderingMode: .alwaysTemplate),
                                tag: 0)
        case .wallet:
            let largerImage = UIImage(named: "walletIcon")
            let tabBarSize = CGSize(width: 30, height: 30)
            UIGraphicsBeginImageContextWithOptions(tabBarSize, false, 0.0)
            largerImage?.draw(in: CGRect(x: 0, y: 0, width: tabBarSize.width, height: tabBarSize.height))
            let tabBarImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return UITabBarItem(title: "",
                                image: tabBarImage?.withTintColor(.white, renderingMode: .alwaysTemplate),
                                tag: 1)
        case .notification:
            return UITabBarItem(title: "",
                                image: UIImage(systemName: "list.and.film")?.withTintColor(.white, renderingMode: .alwaysTemplate),
                                tag: 2)
        case .management:
            return UITabBarItem(title: "",
                                image: UIImage(systemName: "square.and.arrow.down")?.withTintColor(.white, renderingMode: .alwaysTemplate),
                                tag: 3)
        case .setting:
            return UITabBarItem(title: "",
                                image: UIImage(systemName: "person.fill")?.withTintColor(.white, renderingMode: .alwaysTemplate),
                                tag: 4)
        }
    }

}
