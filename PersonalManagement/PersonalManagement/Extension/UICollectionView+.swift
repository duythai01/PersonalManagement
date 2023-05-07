//
//  UICollectionView+.swift
//  PersonalManagement
//
//  Created by DuyThai on 10/05/2023.
//

import Foundation
import UIKit

extension UICollectionView {
    func register<T: UICollectionViewCell>(nibName name: T.Type,
                                           atBundle bundleClass: AnyClass? = nil)where T: ReuseCellType {
        let identifier = T.defaultReuseIdentifier
        let nibName = T.nibName
        var bundle: Bundle?
        if let bundleName = bundleClass {
            bundle = Bundle(for: bundleName)
        }
        register(UINib(nibName: nibName, bundle: bundle), forCellWithReuseIdentifier: identifier)
    }

    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath, cellType: T.Type = T.self) -> T
    where T: ReuseCellType {
        let bareCell = self.dequeueReusableCell(withReuseIdentifier: cellType.defaultReuseIdentifier, for: indexPath)
        guard let cell = bareCell as? T else {
            fatalError("Error dequeueReuseableCell \(cellType.defaultReuseIdentifier)")
        }
        return cell
    }
}
