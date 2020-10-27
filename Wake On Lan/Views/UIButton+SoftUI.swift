//
//  UIButton+SoftUI.swift
//  Wake on LAN
//
//  Created by Dmitry on 09.07.2020.
//  Copyright © 2020 Владислав Лисянский. All rights reserved.
//

import UIKit

class SoftUIButton: UIButton, SoftUIProtocol {

    private let shadowLayerName = "com.wol.soft_shadow_layer"

    // MARK: - Override
    override open var isHighlighted: Bool {
        didSet {
            pressed = isHighlighted ? true : false
        }
    }

    override open var isSelected: Bool {
        didSet {
            pressed = isSelected ? false : true
        }
    }

    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        if roundShape { cornerRadius = bounds.height / 2 }
        addSoftUIEffectIfNeeded()
    }

    // MARK: - Properties
    var themeColor: UIColor

    var cornerRadius: CGFloat

    private var pressed: Bool = false {
        didSet {
            guard let shadowLayer = layer.sublayers?.first else { return }
            switch pressed {
            case true:
                layer.shadowOffset = CGSize(width: -2, height: -2)
                shadowLayer.shadowOffset = CGSize(width: 2, height: 2)
                contentEdgeInsets = UIEdgeInsets(top: 2, left: 2, bottom: 0, right: 0)

            case false:
                layer.shadowOffset = CGSize(width: 2, height: 2)
                shadowLayer.shadowOffset = CGSize(width: -2, height: -2)
                contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 2, right: 2)
            }
        }
    }

    private var roundShape: Bool = false

    // MARK: - Init
    init(roundShape: Bool = false, cornerRadius: CGFloat = 15.0, themeColor: UIColor = .softUIColor) {
        self.roundShape = roundShape
        self.themeColor = themeColor
        self.cornerRadius = cornerRadius

        super.init(frame: .zero)
        self.adjustsImageWhenDisabled = false
        self.adjustsImageWhenHighlighted = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - SoftUIProtocol
    func addSoftUIEffectIfNeeded() {
        self.layer.addBottomRightEffect(cornerRadius: cornerRadius)
        let oldShadowLayer = self.layer.sublayers?.first {
            $0.name == self.shadowLayerName
        }

        let newShadowLayer = makeShadowLayer()
        newShadowLayer.name = shadowLayerName

        if let layer = oldShadowLayer { // Layer already exists
            self.layer.replaceSublayer(layer, with: newShadowLayer)
        } else { // Layer does not exists
            self.layer.insertSublayer(newShadowLayer, below: self.imageView?.layer)
        }
    }

}