//
//  AboutScreenView.swift
//  AboutScreen
//
//  Created by Vladislav Lisianskii on 24.04.2021.
//  Copyright © 2021 Владислав Лисянский. All rights reserved.
//

import UIKit
import WOLUIComponents
import WOLResources
import SnapKit

protocol AboutScreenViewDelegate: AnyObject {
    func aboutScreenViewDidPressBackButton(_ view: AboutScreenView)
}

final class AboutScreenView: UIView {

    // MARK: - Appearance

    private let appearance = Appearance(); struct Appearance {
        let barButtonImageViewInset: CGFloat = 6.0
    }

    // MARK: - Properties

    weak var delegate: AboutScreenViewDelegate?

    lazy var backBarButton: UIBarButtonItem = {
        let button = SoftUIView(circleShape: true)
        let image = WOLResources.Asset.Assets.back.image.with(tintColor: WOLResources.Asset.Colors.lightGray.color)
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        button.configure(with: SoftUIViewModel(contentView: imageView))
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(appearance.barButtonImageViewInset)
        }
        button.snp.makeConstraints { make in
            make.size.equalTo(32)
        }
        button.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)

        return UIBarButtonItem(customView: button)
    }()

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(AboutHeaderTableCell.self, forCellReuseIdentifier: "\(AboutHeaderTableCell.self)")
        tableView.register(MenuButtonTableCell.self, forCellReuseIdentifier: "\(MenuButtonTableCell.self)")
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private methods
private extension AboutScreenView {

    func setupViews() {
        backgroundColor = WOLResources.Asset.Colors.soft.color
        addSubview(tableView)

        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    @objc func backButtonPressed() {
        delegate?.aboutScreenViewDidPressBackButton(self)
    }

}
