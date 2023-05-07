//
//  StartedViewController.swift
//  PersonalManagement
//
//  Created by DuyThai on 06/05/2023.
//

import UIKit

class StartedViewController: UIViewController {
    @IBOutlet private weak var getStartedButton: UIButton!

    var viewModel: StartedViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }

    private func configView()  {
        getStartedButton.layer.cornerRadius = getStartedButton.frame.size.height / 2
    }

}
