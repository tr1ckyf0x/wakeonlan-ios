//
//  ChooseIconContract.swift
//  Wake on LAN
//
//  Created by Dmitry Stavitsky on 28.05.2020.
//  Copyright © 2020 Владислав Лисянский. All rights reserved.
//

import UIKit

protocol ChooseIconViewInput: UIViewController {
    var presenter: ChooseIconViewOutput! { get set }

    func makePresentingViewControllerDimmed()

    func makePresentingViewControllerTransparent()

    func reloadCollectionViewLayout()

    func updateIconViewHeight()
}

protocol ChooseIconViewOutput {
    var tableManager: ChooseIconTableManager { get }

    func viewDidLoad(_ view: ChooseIconViewInput)

    func viewWillLayoutSubviews(_ view: ChooseIconViewInput)

    func viewWillDisappear(_ view: ChooseIconViewInput)
}

extension ChooseIconViewOutput {
    func viewDidLoad(_ view: ChooseIconViewInput) { }

    func viewWillLayoutSubviews(_ view: ChooseIconViewInput) { }
}

protocol ChooseIconRouterProtocol: class {
    var viewController: ChooseIconViewInput? { get }

}

// MARK: - Module delegate
protocol ChooseIconModuleOutput: class {
    func chooseIconModuleDidSelectIcon(_ iconModel: IconModel)

}
