//
//  HomeViewController.swift
//  PersonalManagement
//
//  Created by DuyThai on 08/05/2023.
//

import UIKit

final class HomeViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var avatarImageView: UIImageView!

    private let tableCellType = [ HomeCellType.balance, HomeCellType.note, HomeCellType.chart]
    var viewModel: HomeViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
    }

    private func configTableView() {
        tableView.do {
            $0.delegate = self
            $0.dataSource = self
            $0.estimatedRowHeight = UITableView.automaticDimension
            $0.rowHeight = UITableView.automaticDimension
            $0.register(nibName: BalanceTableViewCell.self)
            $0.register(nibName: NoteTableViewCell.self)
            $0.register(nibName: ChartTableViewCell.self)
        }
    }

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(tableCellType.count)
        return tableCellType.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableCellType[indexPath.row] {
        case .balance:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: BalanceTableViewCell.defaultReuseIdentifier) as? BalanceTableViewCell
            else { return UITableViewCell()}
            cell.selectionStyle = .none
            return cell
        case .note:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NoteTableViewCell.defaultReuseIdentifier) as? NoteTableViewCell
            else { return UITableViewCell()}
            cell.selectionStyle = .none
            return cell
        case .chart:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ChartTableViewCell.defaultReuseIdentifier) as? ChartTableViewCell
            else { return UITableViewCell()}
            cell.selectionStyle = .none
            return cell
        default:
            return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch tableCellType[indexPath.row] {
        case .balance:
            return tableView.frame.width / 2
        case .note:
            return 250
        case .chart:
            return 250
        }
    }

}

enum HomeCellType {
    case balance
    case note
    case chart
}
