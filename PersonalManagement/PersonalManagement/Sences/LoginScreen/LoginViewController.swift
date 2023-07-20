//
//  LoginViewController.swift
//  PersonalManagement
//
//  Created by DuyThai on 07/05/2023.
//

import UIKit
import Then
import RxSwift
import RxCocoa

final class LoginViewController: UIViewController {
    @IBOutlet private weak var googleLoginView: UIView!
    @IBOutlet private weak var forgotPasswordLabel: UILabel!
    @IBOutlet private weak var signUpLabel: UILabel!
    @IBOutlet private weak var appleLoginView: UIView!
    @IBOutlet private weak var facebookLoginView: UIView!
    @IBOutlet private weak var continueButton: UIButton!
    @IBOutlet private weak var phoneNumberTextField: CustomTextField!
    @IBOutlet private weak var containerView: UIView!

    var viewModel: LoginViewModel!
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        hideKeyboardWhenTappedAround()
        continueButton.rx.tap.subscribe(onNext: { [unowned self] _ in
            print("tapped continue")
            viewModel.coordinator.goToMainTabBar()
        })
        .disposed(by: disposeBag)
    }

    private func configView() {
        containerView.layer.cornerRadius = CornerRadiousType.containerView.value
        containerView.applyBlurEffect()

        googleLoginView.layer.cornerRadius = CornerRadiousType.button.value
        appleLoginView.layer.cornerRadius = CornerRadiousType.button.value
        facebookLoginView.layer.cornerRadius = CornerRadiousType.button.value
        continueButton.layer.cornerRadius = CornerRadiousType.button.value

        phoneNumberTextField.then {
            $0.delegate = self
            $0.layer.cornerRadius = CornerRadiousType.button.value

            $0.attributedPlaceholder = NSAttributedString(
                string: "Phone number",
                attributes: [NSAttributedString.Key.foregroundColor: UIColor(#colorLiteral(red: 0.5153685212, green: 0.5153685212, blue: 0.5153685212, alpha: 1))]
            )
        }
    }
}

extension LoginViewController: UITextFieldDelegate {

    func textFieldDidBeginEditing(_ textField: UITextField) {
        phoneNumberTextField.layer.borderWidth = 1.6
        phoneNumberTextField.layer.borderColor = UIColor.green.cgColor
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        phoneNumberTextField.layer.borderWidth = 0
    }
}
