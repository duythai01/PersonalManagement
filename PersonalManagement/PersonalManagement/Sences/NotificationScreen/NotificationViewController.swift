//
//  NotificationViewController.swift
//  PersonalManagement
//
//  Created by DuyThai on 08/05/2023.
//

import UIKit
import TinyConstraints

final class NotificationViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var viewModel: NotificationViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.hidesBarsOnSwipe = true
        tableView.do {
            $0.delegate = self
            $0.dataSource = self
            $0.estimatedRowHeight = UITableView.automaticDimension
            $0.rowHeight = 220
            $0.register(nibName: CardTableViewCell.self)
        }
    }
    func createCustomContextualAction() -> UIContextualAction {
            let customAction = UIContextualAction(style: .normal, title: "Custom Action") { (action, view1, completionHandler) in
//                view1.backgroundColor = .clear
                // Perform your custom action here
                completionHandler(true)
            }

        let containerView = UIView()
//        containerView.do {
//            $0.leadingToSuperview()
//            $0.trailingToSuperview()
//            $0.topToSuperview()
//            $0.bottomToSuperview(offset: 16)
//            $0.backgroundColor = .red
//        }

//             Customize the appearance of the custom action
            customAction.backgroundColor = UIColor.white // Set the background color to white
            customAction.image = UIImage(systemName: "star.fill") // Optional: You can also set an image

            // Add a border to the action
//            customAction.backgroundColor = UIColor.clear // Clear the background color to enable custom drawing
//            customAction.image = nil // Clear the image to enable custom drawing
            customAction.backgroundColor = UIColor.white // Set the background color to white
            customAction.image = UIImage(systemName: "star.fill") // Optional: You can also set an image

            // Create a border for the action
//            let border = CALayer()
//            border.frame = CGRect(x: 0, y: 0, width: customAction.image?.size.width ?? 30.0, height: customAction.image?.size.height ?? 30.0)
//            border.borderColor = UIColor.blue.cgColor
//            border.borderWidth = 2.0
//            border.cornerRadius = 16 // Optional: You can set the corner radius to give a rounded border
//            customAction.image?.draw(in: border.bounds)
//            border.contents = UIGraphicsGetImageFromCurrentImageContext()?.cgImage
//            UIGraphicsEndImageContext()

            return customAction
        }

}

extension NotificationViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CardTableViewCell.defaultReuseIdentifier) as? CardTableViewCell
        else { return UITableViewCell()}
        cell.selectionStyle = .none
        cell.configView()
        return cell
    }

    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "delete") {a,b,c in
            print (a)
            print(b)
            print(c )
        }
        delete.backgroundColor = UIColor.blue
        delete.image = UIImage(systemName: "star.fill")
        return UISwipeActionsConfiguration(actions: [createCustomContextualAction()])
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}
