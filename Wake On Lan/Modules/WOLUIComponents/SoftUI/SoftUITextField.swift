//
//  SoftUITextField.swift
//  WOLUIComponents
//
//  Created by Dmitry on 14.02.2021.
//  Copyright © 2021 Владислав Лисянский. All rights reserved.
//

import UIKit
import WOLResources

public class SoftUITextField: UITextField {

    // MARK: - Appearance

    private let appearance = Appearance(); struct Appearance {
        var mainColor: CGColor { WOLResources.Asset.Colors.soft.color.resolved }
        var darkShadowColor: CGColor { WOLResources.Asset.Colors.darkSoftShadow.color.resolved }
        var lightShadowColor: CGColor { WOLResources.Asset.Colors.lightSoftShadow.color.resolved }

        var darkShadowOpacity: Float {
            guard #available(iOS 13.0, *) else { return 1 }
            return UITraitCollection.current.userInterfaceStyle == .dark ? 0.6 : 1
        }

        var lightShadowOpacity: Float {
            guard #available(iOS 13.0, *) else { return 1 }
            return UITraitCollection.current.userInterfaceStyle == .dark ? 0.2 : 1
        }

        let shadowOffset = CGSize(width: 2, height: 2)
        let shadowRadius = CGFloat(2)
        let cornerRadius = CGFloat(15)

        let textRectInset = CGPoint(x: 15, y: 10)
        let editingRectInset = CGPoint(x: 15, y: 10)
        let clearButtonRectInset = CGPoint(x: -10, y: 0)

    }

    // MARK: - Properties

    lazy var mainColor = appearance.mainColor {
        didSet {
            backgroundLayer.backgroundColor = mainColor
            darkInnerShadowLayer.fillColor = mainColor
            lightInnerShadowLayer.fillColor = mainColor
        }
    }

    lazy var darkShadowColor = appearance.darkShadowColor {
        didSet { darkInnerShadowLayer.shadowColor = darkShadowColor }
    }

    lazy var lightShadowColor = appearance.lightShadowColor {
        didSet { lightInnerShadowLayer.shadowColor = lightShadowColor }
    }

    lazy var lightShadowOpacity: Float = appearance.lightShadowOpacity {
        didSet { updateShadowOpacity() }
    }

    lazy var darkShadowOpacity: Float = appearance.darkShadowOpacity {
        didSet { updateShadowOpacity() }
    }

    lazy var shadowOffset = appearance.shadowOffset {
        didSet {
            darkInnerShadowLayer.shadowOffset = shadowOffset
            lightInnerShadowLayer.shadowOffset = shadowOffset.inverse
        }
    }

    lazy var cornerRadius: CGFloat = appearance.cornerRadius {
        didSet { updateSublayersShape() }
    }

    lazy var shadowRadius = appearance.shadowRadius {
        didSet {
            darkInnerShadowLayer.shadowRadius = shadowRadius
            lightInnerShadowLayer.shadowRadius = shadowRadius
        }
    }

    // MARK: - Layers

    private lazy var backgroundLayer: CALayer = {
        let layer = CALayer()
        layer.frame = bounds
        layer.cornerRadius = cornerRadius
        layer.backgroundColor = mainColor

        return layer
    }()

    private lazy var darkInnerShadowLayer: CAShapeLayer = {
        makeInnerShadowLayer(shadowColor: darkShadowColor, shadowOffset: shadowOffset)
    }()

    private lazy var lightInnerShadowLayer: CAShapeLayer = {
        makeInnerShadowLayer(shadowColor: lightShadowColor, shadowOffset: shadowOffset.inverse)
    }()

    // MARK: - Init

    override public init(frame: CGRect) {
        super.init(frame: frame)
        addSublayers()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func draw(_ rect: CGRect) {
        super.draw(rect)
        updateSublayersShape()
        updateShadowOpacity()
    }

    // MARK: - Override

    override public func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.insetBy(dx: appearance.textRectInset.x, dy: appearance.textRectInset.y)
    }

    override public func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.insetBy(dx: appearance.editingRectInset.x, dy: appearance.editingRectInset.y)
    }

    override public func clearButtonRect(forBounds bounds: CGRect) -> CGRect {
        let clearButtonRect = super.clearButtonRect(forBounds: bounds)
        return clearButtonRect.offsetBy(
            dx: appearance.clearButtonRectInset.x,
            dy: appearance.clearButtonRectInset.y
        )
    }

    override public func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if
            #available(iOS 13, *),
            traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            updateAppearance()
        }
    }

}

private extension SoftUITextField {

    func addSublayers() {
        layer.addSublayer(backgroundLayer)
        layer.addSublayer(darkInnerShadowLayer)
        layer.addSublayer(lightInnerShadowLayer)
    }

    func makeInnerShadowLayer(shadowColor: CGColor, shadowOffset: CGSize) -> CAShapeLayer {
        let layer = CAShapeLayer()
        layer.fillColor = mainColor
        layer.shadowColor = shadowColor
        layer.shadowOffset = shadowOffset
        layer.shadowRadius = shadowRadius
        layer.backgroundColor = UIColor.clear.cgColor
        layer.fillRule = .evenOdd

        return layer
    }

    func makeInnerShadowPath() -> CGPath {
        let path = UIBezierPath(roundedRect: bounds.insetBy(dx: -100, dy: -100), cornerRadius: cornerRadius)
        path.append(.init(roundedRect: bounds, cornerRadius: cornerRadius))
        return path.cgPath
    }

    func makeInnerShadowMask() -> CALayer {
        let layer = CAShapeLayer()
        layer.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
        return layer
    }

    func updateSublayersShape() {
        backgroundLayer.frame = bounds
        backgroundLayer.cornerRadius = cornerRadius

        darkInnerShadowLayer.path = makeInnerShadowPath()
        darkInnerShadowLayer.mask = makeInnerShadowMask()

        lightInnerShadowLayer.path = makeInnerShadowPath()
        lightInnerShadowLayer.mask = makeInnerShadowMask()
    }

    func updateAppearance() {
        mainColor = appearance.mainColor

        shadowOffset = appearance.shadowOffset
        shadowRadius = appearance.shadowRadius
        cornerRadius = appearance.cornerRadius

        darkShadowColor = appearance.darkShadowColor
        lightShadowColor = appearance.lightShadowColor
        darkShadowOpacity = appearance.darkShadowOpacity
        lightShadowOpacity = appearance.lightShadowOpacity
    }

    func updateShadowOpacity() {
        darkInnerShadowLayer.shadowOpacity = darkShadowOpacity
        lightInnerShadowLayer.shadowOpacity = lightShadowOpacity
    }

}
