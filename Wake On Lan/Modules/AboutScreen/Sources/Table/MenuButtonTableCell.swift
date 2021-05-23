//
//  MenuButtonTableCell.swift
//  AboutScreen
//
//  Created by Vladislav Lisianskii on 23.05.2021.
//  Copyright © 2021 Владислав Лисянский. All rights reserved.
//

import UIKit
import WOLResources
import SnapKit
import WOLUIComponents

final class MenuButtonTableCell: UITableViewCell {

    private lazy var buttonBodyView: SoftUIView = {
        let view = SoftUIView()
        view.configure(with: SoftUIViewModel(contentView: buttonTitleLabel))
        view.type = .pushButton
        view.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return view
    }()

    private lazy var buttonTitleLabel: UILabel = {
        let label = UILabel()
        label.font = WOLResources.FontFamily.Roboto.bold.font(size: 14)
        label.textColor = WOLResources.Asset.Colors.lightGray.color
        return label
    }()

    private var action: (() -> Void)?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        action = nil
    }

}

// MARK: - Internal methods
extension MenuButtonTableCell {
    func configure(title: String, action: @escaping () -> Void) {
        buttonTitleLabel.text = title
        self.action = action
    }
}

// MARK: - Private methods
private extension MenuButtonTableCell {
    func setupViews() {
        contentView.addSubview(buttonBodyView)

        buttonBodyView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.bottom.equalToSuperview().inset(8)
        }
    }

    @objc func buttonPressed() {
        action?()
    }
}
