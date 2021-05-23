//
//  AboutScreenPresenter.swift
//  AboutScreen
//
//  Created by Vladislav Lisianskii on 24.04.2021.
//  Copyright © 2021 Владислав Лисянский. All rights reserved.
//

import Foundation
import SharedProtocols
import WOLResources

final class AboutScreenPresenter<Router: AboutScreenRouterProtocol> {

    weak var view: AboutScreenViewInput?

    var router: Router?

    var interactor: AboutScreenInteractorInput?

    var tableManager: AboutScreenTableManager?

}

// MARK: - Private methods
private extension AboutScreenPresenter {
    private func setupSectionModels() {
        let appVersionItem = AboutScreenSectionModel.Item.header(appName: WOLResources.L10n.AboutScreen.applicationName,
                                                                 appVersion: interactor?.appVersion)
        let rateAppItem = AboutScreenSectionItem.menuButton(title: "Test", action: {})
        tableManager?.sections = [.mainSection(content: [appVersionItem,
                                                         rateAppItem],
                                               header: nil,
                                               footer: nil)]
    }
}

// MARK: - AboutScreenViewOutput
extension AboutScreenPresenter: AboutScreenViewOutput {

    func viewDidLoad(_ view: AboutScreenViewInput) {
        setupSectionModels()
    }

    func viewDidPressBackButton(_ view: AboutScreenViewInput) {
        router?.popCurrentController(animated: true)
    }

}

// MARK: - AboutScreenInteractorOutput
extension AboutScreenPresenter: AboutScreenInteractorOutput {
}
