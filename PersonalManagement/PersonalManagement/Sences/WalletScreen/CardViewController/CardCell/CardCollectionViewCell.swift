//
//  CardCollectionViewCell.swift
//  PersonalManagement
//
//  Created by DuyThai on 05/09/2023.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell, ReuseCellType {

    @IBOutlet private weak var background: UIImageView!
    @IBOutlet private weak var expiredDateLabel: UILabel!
    @IBOutlet private weak var serialNumberLabel: UILabel!
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var containerShadowView: UIView!
    @IBOutlet private weak var addCardButton: UIButton!
    @IBOutlet private weak var currentBalanceLabel: UILabel!
    @IBOutlet private weak var addCardView: UIView!
    @IBOutlet private weak var lastCellViewCustom: LastCellViewCustom!

    let backgroundImages = [UIImage(named: "Terminal"),
                            UIImage(named: "Dusk"),
                            UIImage(named: "Flickr"),
                            UIImage(named: "Ash"),
                            UIImage(named: "Deep Space"),
                            UIImage(named: "Flare"),
                            UIImage(named: "Harvey"),
                            UIImage(named: "Mirage"),
//                            UIImage(named: "Monnlit Asteroid"),
                            UIImage(named: "Quepal"),
                            UIImage(named: "Very Blue"),
                            UIImage(named: "Rea"),]

    override func awakeFromNib() {
        super.awakeFromNib()
        containerShadowView.layer.cornerRadius = 16
        containerView.layer.cornerRadius = 16
        containerView.layer.borderWidth = 3
        containerView.layer.borderColor = UIColor.white.cgColor

        addCardView.isHidden = true
        addCardView.layer.borderWidth = 2
        addCardView.layer.borderColor = UIColor.red.cgColor

        lastCellViewCustom.isHidden = true


        serialNumberLabel.applyShadow()

        addCardButton.layer.cornerRadius = 8
        configView()
    }
    func configView() {
        let backgroundImage = backgroundImages[Int.random(in: 0...backgroundImages.count - 1)]
        background.image = backgroundImage
//        serialNumberLabel.text = serialNumber
//        expiredDateLabel.text = expiredDate
    }

    func isAddCardCell() {
        addCardView.isHidden = false
    }

    func isLastCell() {
        lastCellViewCustom.isHidden = false
        containerView.isHidden = true
        lastCellViewCustom.backgroundColor = .clear
    }
}
