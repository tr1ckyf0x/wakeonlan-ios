//
//  DeviceIconCellView.swift
//  Wake on LAN
//
//  Created by Dmitry Stavitsky on 28.05.2020.
//  Copyright © 2020 Владислав Лисянский. All rights reserved.
//

import UIKit

protocol DeviceIconViewDelegate {
    func didTapChangeIcon(_ view: DeviceIconView)
}

class DeviceIconView: UIView {

    var delegate: DeviceIconViewDelegate?

    // MARK: - Properties
    private lazy var deviceImageView: UIImageView = {
        let image = R.image.desktop()?.withRenderingMode(.alwaysTemplate)
        let imageView = UIImageView(image: image)
        imageView.layer.cornerRadius = 14
        imageView.tintColor = .systemGray
        imageView.isUserInteractionEnabled = true

        // Add tap gesture recognizer
        let tapGestureRecognizer =
            UITapGestureRecognizer(target: self, action: #selector(didTapChangeIcon))
        imageView.addGestureRecognizer(tapGestureRecognizer)

        return imageView
    }()

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupDeviceImageView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func configure(with model: IconModel) {
        guard let icon = model.picture else { return }
        deviceImageView.image = icon
    }

    // MARK: - Private
    private func setupDeviceImageView() {
        addSubview(deviceImageView)
        deviceImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.width.equalTo(deviceImageView.snp.height)
        }
    }

    // MARK: - Action
    @objc private func didTapChangeIcon() {
        delegate?.didTapChangeIcon(self)
    }

}