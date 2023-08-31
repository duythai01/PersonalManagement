//
//  HomeViewController.swift
//  PersonalManagement
//
//  Created by DuyThai on 08/05/2023.
//

import UIKit
import RxCocoa
import RxSwift

final class HomeViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var avatarImageViewContainer: UIView!
    @IBOutlet private weak var avatarImageShadow: UIView!

    @IBOutlet weak var customAvatarContainerView: CustomView!

    private let tableCellType = [ HomeCellType.space, HomeCellType.balance, HomeCellType.note, HomeCellType.chart]
    var viewModel: HomeViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        avatarImageViewContainer.applyCircle()
        avatarImageShadow.layer.cornerRadius = 30
        customAvatarContainerView.applyShadow()
        avatarImageShadow.applyShadow()
        configTableView()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        avatarImageView.addGestureRecognizer(tapGestureRecognizer)
    }
    @objc func imageTapped() {
        print("Image tapped!")
        // Add your custom code to respond to the tap event here
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 5.0, delay: 0.0, options: [.curveEaseOut], animations: {
            self.customAvatarContainerView.frame = CGRect(x: 0, y:  self.customAvatarContainerView.frame.minY, width: self.customAvatarContainerView.frame.size.width, height: 100)
               }, completion: nil)
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
            let cell = UITableViewCell()
            cell.backgroundColor = .clear
            return cell
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
        case .space:
            return 30

        }
    }

}

enum HomeCellType {
    case space
    case balance
    case note
    case chart
}

class CustomView: UIView {
    

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let point3RatioX: CGFloat = 70 / 352

        let pointXRatioX: CGFloat = 75 / 352
        let pointXRatioY: CGFloat = 50 / 60

        let point4RatioX: CGFloat = 100 / 352
        let point4RatioY: CGFloat = 45 / 60

        let point5RatioY: CGFloat = 45 / 60

//        let point3RatioX = 70 / 390

        // Create a new UIBezierPath
        let path = UIBezierPath()

        // Define the triangle's points
        let point1 = CGPoint(x: rect.minX, y: rect.minY) // Top-Left
        let point2 = CGPoint(x: rect.minX, y: rect.maxY) // Bottom-left
        let point3 = CGPoint(x: point3RatioX * rect.maxX, y: rect.maxY)
        let pointx = CGPoint(x: pointXRatioX * rect.maxX, y: pointXRatioY * rect.maxY)
        let point4 = CGPoint(x: point4RatioX *  rect.maxX, y: point4RatioY * rect.maxY)
        let point5 = CGPoint(x: rect.maxX, y: point5RatioY * rect.maxY)
        let point6 = CGPoint(x: rect.maxX, y: rect.minY) // Top-Right

        // Add the points to the path
        path.move(to: point1)
        path.addLine(to: point2)
        // Add a rounded corner from point2 to point3
//        path.addLine(to: point3)
//        path.addQuadCurve(to: point2, controlPoint: CGPoint(x: 0, y: rect.maxY))

        // Add a rounded corner from point3 to point4
        path.addQuadCurve(to: point3, controlPoint: CGPoint(x: point3RatioX * rect.maxX + 30, y: rect.maxY))
//        path.addLine(to: pointx)
        path.addQuadCurve(to: point4, controlPoint: CGPoint(x: 80, y: 51))

        // Add a rounded corner from point4 to point5
        path.addLine(to: point5)

        path.addLine(to: point6)

        // Close the path (draws a line back to the starting point)
        path.close()

        // Set the fill color
        UIColor.green.setFill()
        path.fill()
    }
}
