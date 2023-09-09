//
//  ViewModelType.swift
//  PersonalManagement
//
//  Created by DuyThai on 05/09/2023.
//

import Foundation
import RxSwift

protocol ViewModelType {
    associatedtype Input
    associatedtype Output

    func transform(input: Input, disposeBag: DisposeBag) -> Output
}
