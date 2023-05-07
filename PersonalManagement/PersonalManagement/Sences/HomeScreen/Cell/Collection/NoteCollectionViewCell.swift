//
//  NoteCollectionViewCell.swift
//  PersonalManagement
//
//  Created by DuyThai on 10/05/2023.
//

import UIKit

class NoteCollectionViewCell: UICollectionViewCell, ReuseCellType {

    @IBOutlet private weak var contentTextView: UITextView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var priorityLevelLabel: UILabel!
    @IBOutlet private weak var priotityTagView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        configView()
    }

    private func configView() {
        layer.cornerRadius = CornerRadiousType.cell.value
        priotityTagView.layer.cornerRadius = 4
//        priotityTagView.backgroundColor = .red
        self.applyShadow()
//        contentView.applyShadow()
    }

    func updateCell(title: String, content: String) {
        titleLabel.text = title
        contentTextView.text = content
    }

}
