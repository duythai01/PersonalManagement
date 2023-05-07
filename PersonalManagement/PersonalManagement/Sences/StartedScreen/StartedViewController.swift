//
//  StartedViewController.swift
//  PersonalManagement
//
//  Created by DuyThai on 06/05/2023.
//

import UIKit
import RxCocoa
import RxSwift

class StartedViewController: UIViewController {
    @IBOutlet private weak var getStartedButton: UIButton!

    var viewModel: StartedViewModel!
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        configView()

        getStartedButton.rx.tap.subscribe(onNext: {
            self.viewModel.coordinator.toLoginViewController()
        })
        .disposed(by: disposeBag)
    }

    private func configView()  {
        getStartedButton.layer.cornerRadius = getStartedButton.frame.size.height / 2
    }

}
