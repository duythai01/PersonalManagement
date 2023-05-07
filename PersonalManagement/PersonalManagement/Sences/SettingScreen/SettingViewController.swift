//
//  SettingViewController.swift
//  PersonalManagement
//
//  Created by DuyThai on 08/05/2023.
//

import UIKit
import CalendarKit
import TinyConstraints
import EventKit

class SettingViewController: UIViewController {
    @IBOutlet weak var containerView: UIView!

    private let eventStore = EKEventStore()
    var viewModel: SettingViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUICalendar()
    }

    private func updateUICalendar() {
        let calendarViewController = CalendarViewController()
        self.addChild(calendarViewController)
        containerView.addSubview(calendarViewController.view)
        calendarViewController.view.edgesToSuperview()
        calendarViewController.didMove(toParent: self)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateUICalendar()
    }
    
}


