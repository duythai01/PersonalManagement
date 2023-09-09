//
//  CardViewController.swift
//  PersonalManagement
//
//  Created by DuyThai on 05/09/2023.
//

import UIKit

class CardViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!

    var viewModel: NotificationViewModel!

    private var isHiddenTableView = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationController?.hidesBarsOnSwipe = true

        collectionViewHeight.constant = 178 * 3 + 42
        tableView.do {
            $0.delegate = self
            $0.dataSource = self
            $0.estimatedRowHeight = UITableView.automaticDimension
            $0.rowHeight = 220
            $0.register(nibName: CardTableViewCell.self)
            $0.isHidden = isHiddenTableView
        }

        collectionView.do {
            $0.delegate = self
            $0.dataSource = self
            $0.register(nibName: CardCollectionViewCell.self)
            $0.isHidden = !isHiddenTableView
        }
    }

    func createCustomContextualAction() -> UIContextualAction {
        let customAction = UIContextualAction(style: .normal, title: "Custom Action") { (action, view1, completionHandler) in
            completionHandler(true)
        }

        let containerView = UIView()
        customAction.backgroundColor = UIColor.white // Set the background color to white
        customAction.image = UIImage(systemName: "star.fill") // Optional: You can also set an image
        customAction.backgroundColor = UIColor.white // Set the background color to white
        customAction.image = UIImage(systemName: "star.fill") // Optional: You can also set an image

        return customAction
    }

    func displayNotification(index: Int) {
        let content = UNMutableNotificationContent()
        content.title = "Button Notification \(index)"
        content.body = "This notification was triggered by a button click.\(index)"
        content.sound = UNNotificationSound.default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.1, repeats: false) // Trigger immediately

        let request = UNNotificationRequest(identifier: "buttonNotification", content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("Error scheduling notification: \(error)")
            } else {
                print("Notification scheduled successfully.")
            }
        }
    }

    @IBAction private func swapTappedTapped(_ sender: Any) {
        isHiddenTableView = !isHiddenTableView
        tableView.isHidden = isHiddenTableView
        collectionView.isHidden = !isHiddenTableView


    }


}

extension CardViewController: UITableViewDelegate, UITableViewDataSource {
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        displayNotification(index: indexPath.row)
        print("Sucesseno tapeed")
    }

}


extension CardViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCollectionViewCell.defaultReuseIdentifier, for: indexPath) as? CardCollectionViewCell else { return UICollectionViewCell() }

        if indexPath.row == 3 {
            cell.isAddCardCell()
        }

        if indexPath.row == 4 {
            cell.isLastCell()
        }

        return cell

    }

}
