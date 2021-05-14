//
//  AboutHeaderTableCell.swift
//  AboutScreen
//
//  Created by Vladislav Lisianskii on 24.04.2021.
//  Copyright © 2021 Владислав Лисянский. All rights reserved.
//

import UIKit
import WOLResources
import SnapKit

final class AboutHeaderTableCell: UITableViewCell {

    private lazy var appNameLabel: UILabel = {
        let label = UILabel()
        label.text = WOLResources.L10n.AboutScreen.applicationName
        label.font = WOLResources.FontFamily.Roboto.medium.font(size: 36)
        label.textColor = WOLResources.Asset.Colors.gray900.color
        return label
    }()

    private lazy var appVersionLabel: UILabel = {
        let label = UILabel()
        label.font = WOLResources.FontFamily.Roboto.medium.font(size: 12)
        label.textColor = WOLResources.Asset.Colors.gray.color
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - Internal methods
extension AboutHeaderTableCell {
    func configure(appName: String, appVersion: String) {
        appNameLabel.text = appName
        appVersionLabel.text = appVersion
    }
}

// MARK: - Private methods
private extension AboutHeaderTableCell {
    func setupViews() {
        contentView.addSubview(appNameLabel)
        contentView.addSubview(appVersionLabel)

        appNameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(16)
        }

        appVersionLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(appNameLabel.snp.bottom).offset(8)
            make.bottom.equalToSuperview()
        }
    }
}