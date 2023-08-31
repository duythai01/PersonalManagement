//
//  AppDelegate.swift
//  PersonalManagement
//
//  Created by DuyThai on 06/05/2023.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?
    var staredCoordinator: MainTabBarCoordinator?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            if granted {
                print("Permission granted.")
            } else {
                print("Permission denied.")
            }
        }
        window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = BaseNavigationController()
        staredCoordinator = MainTabBarCoordinator(navigationController: navigationController)
        staredCoordinator?.toMainTabBar()
        navigationController.isNavigationBarHidden = true
        window?.rootViewController = navigationController
        window?.overrideUserInterfaceStyle = .light
        window?.makeKeyAndVisible()
        return true
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
            // Customize notification presentation options here, e.g., to show an alert
            completionHandler([.alert, .sound])
        }
}
