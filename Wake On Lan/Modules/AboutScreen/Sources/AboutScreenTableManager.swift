//
//  AboutScreenTableManager.swift
//  AboutScreen
//
//  Created by Vladislav Lisianskii on 02.05.2021.
//  Copyright © 2021 Владислав Лисянский. All rights reserved.
//

import UIKit

final class AboutScreenTableManager: NSObject {

    // MARK: - Properties

    var sections: [AboutScreenSectionModel] = []
}

// MARK: - UITableViewDataSource

extension AboutScreenTableManager: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections[section].items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell?
        let model = sections[indexPath.section].items[indexPath.row]

        switch model {
        case let .header(appVersion):
            let headerCell = tableView.dequeueReusableCell(
                withIdentifier: "\(AboutHeaderTableCell.self)",
                for: indexPath) as? AboutHeaderTableCell
            headerCell?.configure(appName: "", appVersion: appVersion)

            cell = headerCell
        }

        guard let unwrappedCell = cell else { fatalError("Unknown cell identifier") }

        return unwrappedCell
    }

}

// MARK: - UITableViewDelegate

extension AboutScreenTableManager: UITableViewDelegate {

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        sections[section].header
    }

    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        sections[section].footer
    }

}