//
//  UITableView+.swift
//  PersonalManagement
//
//  Created by DuyThai on 10/05/2023.
//

import Foundation
import UIKit

extension UITableView {
    func register<T: UITableViewCell>(nibName name: T.Type,
                                      atBundle bundleClass: AnyClass? = nil) where T: ReuseCellType {
        let identifier = T.defaultReuseIdentifier
        let nibName = T.nibName
        var bundle: Bundle? = nil
        if let bundleName = bundleClass {
            bundle = Bundle(for: bundleName)
        }
        register(UINib(nibName: nibName, bundle: bundle), forCellReuseIdentifier: identifier)
    }

    func dequeueReusableCell<T: UITableViewCell>(_ type: T.Type) -> T? where T: ReuseCellType {
        guard let cell =  self.dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier) as? T else {
            return nil
        }
        return cell
    }

    func registerFooterHeader<T: UITableViewCell>(nibName name: T.Type, atBundle bundleClass: AnyClass? = nil) where T: ReuseCellType {
        let identifier = T.defaultReuseIdentifier
        let nibName = T.nibName
        var bundle: Bundle? = nil
        if let bundleName = bundleClass {
            bundle = Bundle(for: bundleName)
        }
        let nib = UINib(nibName: nibName, bundle: bundle)
        register(nib, forCellReuseIdentifier: identifier)
    }


}
