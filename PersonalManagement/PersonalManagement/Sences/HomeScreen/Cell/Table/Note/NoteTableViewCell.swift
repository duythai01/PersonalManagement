//
//  NoteTableViewCell.swift
//  PersonalManagement
//
//  Created by DuyThai on 10/05/2023.
//

import UIKit

final class NoteTableViewCell: UITableViewCell, ReuseCellType {

    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var seeAllLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        configTableView()
    }

    private func configTableView() {
        print("configview")
        collectionView.do {
            $0.layer.cornerRadius = 12
            $0.delegate = self
            $0.dataSource = self
            $0.register(nibName: NoteCollectionViewCell.self)
            $0.layer.cornerRadius = CornerRadiousType.cell.value
        }
    }
    
}

extension NoteTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: NoteCollectionViewCell.self)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.height - 16, height: collectionView.frame.height - 16)
    }
}
