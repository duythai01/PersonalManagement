//
//  CollectionViewLayoutCustom.swift
//  PersonalManagement
//
//  Created by DuyThai on 08/09/2023.
//

import Foundation
import UIKit

class HozintalOverlappingLayout: UICollectionViewLayout {
    private var attributesArray: [UICollectionViewLayoutAttributes] = []

        override var collectionViewContentSize: CGSize {
            guard let collectionView = collectionView else { return .zero }

            let width = CGFloat(attributesArray.count) * (collectionView.bounds.width)
              let height = collectionView.bounds.height

            return CGSize(width: width, height: height)
        }

        override func prepare() {
            super.prepare()

            guard let collectionView = collectionView else { return }

            attributesArray.removeAll()

            let itemCount = collectionView.numberOfItems(inSection: 0)
            let itemWidth: CGFloat = collectionView.bounds.width / 2.0
            let itemHeight: CGFloat = collectionView.bounds.height
            let spacing: CGFloat = 10.0

            var contentOffset: CGFloat = 0.0

            for item in 0..<itemCount {
                let indexPath = IndexPath(item: item, section: 0)
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)

                let originX = contentOffset
                contentOffset += itemWidth - (itemWidth / 3) + spacing

                attributes.frame = CGRect(x: originX, y: 0, width: itemWidth, height: itemHeight)

                attributesArray.append(attributes)
            }
        }



        override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
            return attributesArray.filter { $0.frame.intersects(rect) }
        }

        override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
            return attributesArray.first { $0.indexPath == indexPath }
        }

        override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
            return true
        }
}

class VerticalOverlappingLayout: UICollectionViewLayout {
    private var attributesArray: [UICollectionViewLayoutAttributes] = []

    override var collectionViewContentSize: CGSize {
        guard let collectionView = collectionView else { return .zero }

        let width = collectionView.bounds.width
        let height = CGFloat(attributesArray.count) * (collectionView.bounds.height)

        return CGSize(width: width, height: height)
    }

    override func prepare() {
        super.prepare()

        guard let collectionView = collectionView else { return }

        attributesArray.removeAll()

        let itemCount = collectionView.numberOfItems(inSection: 0)
        let itemWidth: CGFloat = collectionView.bounds.width
        let itemHeight: CGFloat = 210// Adjust as needed
        let spacing: CGFloat = 10.0
        print("itemCount: \(itemCount)")
        print("numberOfSections: \(collectionView.numberOfSections)")

        var contentOffset: CGFloat = 0.0

        for item in 0..<itemCount {
            let indexPath = IndexPath(item: item, section: 0)
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)

            let originY = contentOffset
            let adjustedItemHeight = item == 0 ? itemHeight : itemHeight - (itemHeight / 4)

            contentOffset += itemHeight - (itemHeight / 1.8) + spacing

            attributes.frame = CGRect(x: 0, y: originY, width: itemWidth, height: itemHeight)

            attributesArray.append(attributes)
        }
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attributesArray.filter { $0.frame.intersects(rect) }
    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return attributesArray.first { $0.indexPath == indexPath }
    }

    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}
