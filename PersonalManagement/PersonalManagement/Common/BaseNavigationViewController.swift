//
//  BaseNavigationViewController.swift
//  PersonalManagement
//
//  Created by DuyThai on 06/05/2023.
//

import Foundation
import UIKit

class BaseNavigationController: UINavigationController {
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
    }

    override func popToRootViewController(animated: Bool) -> [UIViewController]? {
        return super.popToRootViewController(animated: animated)
    }
}
