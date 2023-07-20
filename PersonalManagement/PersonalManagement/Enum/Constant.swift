//
//  Constant.swift
//  PersonalManagement
//
//  Created by DuyThai on 08/05/2023.
//

import Foundation

enum CornerRadiousType {
    case button
    case containerView
    case textField
    case cell

    var value: CGFloat {
        switch self {
        case .button, .cell:
            return 12
        case .containerView:
            return 16
        case.textField:
            return 12
        }
    }
}

enum TextFieldImagePosition {
    case left
    case right
}
