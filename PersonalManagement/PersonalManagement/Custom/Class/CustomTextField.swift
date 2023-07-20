//
//  CustomTextField.swift
//  PersonalManagement
//
//  Created by DuyThai on 08/05/2023.
//

import Foundation
import UIKit

class CustomTextField: UITextField {
    let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)

      override func textRect(forBounds bounds: CGRect) -> CGRect {
          return bounds.inset(by: padding)
      }

      override func editingRect(forBounds bounds: CGRect) -> CGRect {
          return bounds.inset(by: padding)
      }
}
