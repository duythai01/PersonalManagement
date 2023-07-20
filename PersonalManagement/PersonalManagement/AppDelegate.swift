//
//  AppDelegate.swift
//  PersonalManagement
//
//  Created by DuyThai on 06/05/2023.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var staredCoordinator: MainTabBarCoordinator?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = BaseNavigationController()
        staredCoordinator = MainTabBarCoordinator(navigationController: navigationController)
        staredCoordinator?.toMainTabBar()
        navigationController.isNavigationBarHidden = true
        UINavigationBar.appearance().tintColor = .white
        window?.rootViewController = navigationController
        window?.overrideUserInterfaceStyle = .dark
        window?.makeKeyAndVisible()
        return true
    }

}
