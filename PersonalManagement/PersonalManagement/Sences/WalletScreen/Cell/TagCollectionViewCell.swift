//
//  TagCollectionViewCell.swift
//  PersonalManagement
//
//  Created by DuyThai on 22/06/2023.
//

import UIKit

class TagCollectionViewCell: UICollectionViewCell, ReuseCellType {
    @IBOutlet private weak var tagContainerView: UIView!

    @IBOutlet private weak var tagNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        configView()
    }

    private func configView() {
        tagContainerView.layer.cornerRadius =  tagContainerView.frame.size.height / 5
    }

    func configure(tagName: String) {
        tagNameLabel.text = tagName
//        contentView.frame.size.width = tagNameLabel.intrinsicContentSize.width
    }


}
