//
//  UIView+.swift
//  PersonalManagement
//
//  Created by DuyThai on 08/05/2023.
//

import Foundation
import UIKit

extension UIView {
    func applyBlurEffect() {
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.clipsToBounds = true
        blurEffectView.layer.cornerRadius = CornerRadiousType.containerView.value
        addSubview(blurEffectView)
    }

    func applyCircle() {
        self.layer.cornerRadius = self.frame.width / 2.0
        self.clipsToBounds = true
    }

    func applyShadow(color: CGColor = UIColor.black.cgColor,
                     offSet: CGSize = CGSize(width: 2, height: 2),
                     alpha: Float = 0.3,
                     shadowRadius: CGFloat = 1) {
        layer.shadowColor = color
        layer.shadowOffset = offSet
        layer.shadowOpacity = alpha
        layer.shadowRadius = shadowRadius
    }
}
