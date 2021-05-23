//
//  AboutScreenContract.swift
//  AboutScreen
//
//  Created by Vladislav Lisianskii on 24.04.2021.
//  Copyright © 2021 Владислав Лисянский. All rights reserved.
//

import Foundation
import SharedProtocols

protocol AboutScreenViewOutput: AnyObject {

    var tableManager: AboutScreenTableManager? { get }

    func viewDidLoad(_ view: AboutScreenViewInput)

    func viewDidPressBackButton(_ view: AboutScreenViewInput)

}

protocol AboutScreenViewInput: AnyObject {
}

protocol AboutScreenInteractorInput: AnyObject {
    var appVersion: String? { get }
}

protocol AboutScreenInteractorOutput: AnyObject {
}

protocol AboutScreenRouterProtocol: AnyObject, Router where ViewControllerType == AboutScreenViewController {
}
