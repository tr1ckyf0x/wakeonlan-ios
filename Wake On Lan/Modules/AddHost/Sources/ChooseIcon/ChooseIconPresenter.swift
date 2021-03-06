//
//  ChooseIconPresenter.swift
//  Wake on LAN
//
//  Created by Dmitry Stavitsky on 28.05.2020.
//  Copyright © 2020 Владислав Лисянский. All rights reserved.
//

import SharedModels
import WOLUIComponents
import WOLResources

final class ChooseIconPresenter {
    weak var view: ChooseIconViewInput!
    weak var moduleDelegate: ChooseIconModuleOutput?
    var router: ChooseIconRouterProtocol!

    private(set) lazy var tableManager = ChooseIconTableManager(with: sections)

    private let sections: [ChooseIconSection] = {
        [
            [
                WOLResources.Asset.Assets.other,
                WOLResources.Asset.Assets.desktop,
                WOLResources.Asset.Assets.router,
                WOLResources.Asset.Assets.scanner,
                WOLResources.Asset.Assets.tv
            ]
            .map { .icon(IconModel(pictureName: $0.name)) }
        ]
        .map { ChooseIconSection.section(content: $0) }
    }()

}

// MARK: - ChooseIconViewOutput

extension ChooseIconPresenter: ChooseIconViewOutput {

    func viewDidLoad(_ view: ChooseIconViewInput) {
        tableManager.delegate = self
    }

    func viewWillLayoutSubviews(_ view: ChooseIconViewInput) {
        view.reloadCollectionViewLayout()
        view.updateIconViewHeight()
    }

}

// MARK: - ChooseIconTableManagerDelegate

extension ChooseIconPresenter: ChooseIconTableManagerDelegate {
    func tableManager(_ manager: ChooseIconTableManager, didTapIcon icon: IconModel) {
        moduleDelegate?.chooseIconModuleDidSelectIcon(icon)
        view.dismiss(animated: true)
    }

}
