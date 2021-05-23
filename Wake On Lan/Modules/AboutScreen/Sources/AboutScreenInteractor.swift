//
//  AboutScreenInteractor.swift
//  AboutScreen
//
//  Created by Vladislav Lisianskii on 24.04.2021.
//  Copyright © 2021 Владислав Лисянский. All rights reserved.
//

import Foundation
import SharedExtensions

final class AboutScreenInteractor {

    weak var presenter: AboutScreenInteractorOutput?

}

// MARK: - AboutScreenInteractorInput
extension AboutScreenInteractor: AboutScreenInteractorInput {
    var appVersion: String? {
        Bundle.main.appVersion
    }
}
