//
//  UITextField+.swift
//  PersonalManagement
//
//  Created by DuyThai on 08/05/2023.
//

import Foundation
import UIKit

extension UITextField {
    func addImage(image: UIImage?, position: TextFieldImagePosition ) {
        switch position {
        case .left:
            self.leftViewMode = UITextField.ViewMode.always
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
            imageView.image = image
            self.leftView = imageView
        case .right:
            self.rightViewMode = UITextField.ViewMode.always
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
            let image = image
            imageView.image = image
            self.rightView = imageView
        }
    }


}
