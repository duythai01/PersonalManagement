//
//  WalletViewController.swift
//  PersonalManagement
//
//  Created by DuyThai on 13/06/2023.
//

import UIKit
import RxSwift
import RxCocoa

class WalletViewController: UIViewController {

    @IBOutlet private weak var topStackView: UIStackView!
    @IBOutlet private weak var topFunctionStackView: UIStackView!
    @IBOutlet private weak var chartContainerView: UIView!
    @IBOutlet private weak var optionContainerView: UIView!
    @IBOutlet private weak var selectionContainerView: UIView!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var functionContainerView: UIView!
    @IBOutlet private weak var bottomContainerView: UIView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var nameContainerView: UIView!
    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var qrScannerButton: UIButton!
    @IBOutlet private weak var bottomContainerViewTopContrait: NSLayoutConstraint!
    @IBOutlet private weak var topStackViewTopContrait: NSLayoutConstraint!
    @IBOutlet private weak var categoryViewTopContrait: NSLayoutConstraint!

    private var bottomContainerViewTopContraitValue: CGFloat = 0
    private var topStackViewTopContraitValue: CGFloat = 0
    private var previousContentOffset: CGFloat = 0.0
    private var categoryViewTopContraitValue: CGFloat = 0


    let tags = ["All", "Favorite", "Needed", "Avatar","Needed", "Avatar", "Needed", "Avatar", "Contribution", "layout-----aaaaaaaaa", "All", "Excd eaaaf"]

    var viewModel: WalletViewModel!
    private var isSelectedChart = true
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        bottomContainerViewTopContraitValue = bottomContainerViewTopContrait.constant
        topStackViewTopContraitValue = topStackViewTopContrait.constant
        categoryViewTopContraitValue = categoryViewTopContrait.constant
        print(topStackViewTopContraitValue)
        configView()
        topFunctionStackView.alpha = 0
    }
    @IBAction func qrScannerTapped(_ sender: Any) {
        print("QrScanner")
        let qrScannerViewController = QRScannerViewController()
        self.navigationController?.pushViewController(qrScannerViewController, animated: true)
    }

    private func configView() {
        avatarImageView.do {
            $0.applyCircle()
            $0.layer.borderWidth = 3
            $0.layer.borderColor = UIColor.white.cgColor
        }

        nameContainerView.layer.cornerRadius = nameContainerView.frame.height / 2
        bottomContainerView.layer.cornerRadius = 24
        selectionContainerView.applyShadow()

        functionContainerView.do {
            $0.layer.cornerRadius = 12
            $0.applyShadow()
        }

        chartContainerView.do {
            $0.layer.cornerRadius = $0.frame.height / 3
            $0.backgroundColor = !isSelectedChart ? .white : .clear
        }

        optionContainerView.do {
            $0.layer.cornerRadius = $0.frame.height / 3
            $0.backgroundColor = isSelectedChart ? .white : .clear
        }

        selectionContainerView.layer.cornerRadius = 12
        collectionView.layer.cornerRadius = 12

        tableView.do {
            $0.delegate = self
            $0.dataSource = self
            $0.estimatedRowHeight = UITableView.automaticDimension
            $0.rowHeight = UITableView.automaticDimension
//            $0.contentInset = UIEdgeInsets(top: -40, left: 0, bottom: -20, right: 0)
            $0.register(nibName: CoinTableViewCell.self)
        }

        collectionView.do {
            $0.delegate = self
            $0.dataSource = self
            $0.register(nibName: TagCollectionViewCell.self)
            ($0.collectionViewLayout as? UICollectionViewFlowLayout)?.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
            $0.applyShadow()
        }


    }

}

extension WalletViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CoinTableViewCell.defaultReuseIdentifier) as? CoinTableViewCell
        else { return UITableViewCell()}
        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 80
        
    }


    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == tableView {
            let tableViewHeight = tableView.bounds.size.height
            let scrollThreshold = tableViewHeight / 5
            let contentOffsetY = scrollView.contentOffset.y
            let scrollPercentage = contentOffsetY / scrollThreshold
            let normalizedPercentage = max(min(scrollPercentage, 1.0), 0.0)
            let alpha = 1.0 - normalizedPercentage
            let topContraitSpaceMax: CGFloat = 22

            functionContainerView.alpha = round((alpha) * 10) / 10.0
            print("alpha: \(round((alpha) * 10) / 10.0)")
            topStackView.alpha = round((alpha) * 10) / 10.0
            topFunctionStackView.alpha = round((1 - alpha) * 10) / 10.0
            nameContainerView.alpha = round((alpha) * 10) / 10.0

            let currentContentOffset = scrollView.contentOffset.y
                    if currentContentOffset > previousContentOffset {
                        // Scrolling downwards
                        print("Scrolling Down")

                        topStackViewTopContrait.constant =  topStackViewTopContrait.constant > 30 ? topStackViewTopContraitValue * alpha : 30
                        bottomContainerViewTopContrait.constant =  bottomContainerViewTopContrait.constant > 16 ? bottomContainerViewTopContraitValue * alpha : 16

                        if (round((alpha) * 10) / 10.0) <= 0.3 {
                            categoryViewTopContrait.constant = 8 - topContraitSpaceMax
                        }

                    } else if currentContentOffset < previousContentOffset {
                        // Scrolling upwards
                        print("Scrolling Up")
                         let scaleTopContrait = bottomContainerViewTopContraitValue * alpha
                        bottomContainerViewTopContrait.constant  = scaleTopContrait < 16 ? 16 : scaleTopContrait

                        topStackViewTopContrait.constant  = topStackViewTopContraitValue * alpha < 30 ? 30 : topStackViewTopContraitValue * alpha
                        if (round((alpha) * 10) / 10.0) >= 0.4 {
                            categoryViewTopContrait.constant = 8
                        }

                    }

                    previousContentOffset = currentContentOffset
        }
    }

}

extension WalletViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tags.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(for: indexPath,
                                                  cellType: TagCollectionViewCell.self).with {
            $0.configure(tagName: tags[indexPath.row])
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: collectionView.frame.width / 2,
                      height: collectionView.frame.height)
    }


}

