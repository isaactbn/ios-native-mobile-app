//
//  UIView+Extension.swift
//  NativeMobileApp
//
//  Created by Issac on 12/06/22.
//

import UIKit

enum RadiusType {
    case rounded
    case quarter
    case custom(CGFloat)
}

extension UIView {
    
    fileprivate typealias Action = (() -> Void)?
    
    func setupRadius(type: RadiusType, isMaskToBounds: Bool = false) {
        var radius: CGFloat = 0.0
        
        switch type {
        case .rounded:
            radius = frame.width / 2
        case .quarter:
            radius = frame.width / 4
        case .custom(let value):
            radius = value
        }
        
        layer.cornerRadius = radius
        layer.masksToBounds = isMaskToBounds
    }
    
    fileprivate struct AssociatedObjectKeys {
        static var tapGestureRecognizer = "MediaViewerAssociatedObjectKey_mediaViewer"
    }
    
    fileprivate var tapGestureRecognizerAction: Action? {
        set {
            if let newValue = newValue {
                // Computed properties get stored as associated objects
                objc_setAssociatedObject(self, &AssociatedObjectKeys.tapGestureRecognizer, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            }
        }
        get {
            let tapGestureRecognizerActionInstance = objc_getAssociatedObject(self, &AssociatedObjectKeys.tapGestureRecognizer) as? Action
            return tapGestureRecognizerActionInstance
        }
    }
    
    @objc func tapGesture(action: (() -> Void)?) {
        isUserInteractionEnabled = true
        tapGestureRecognizerAction = action
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc fileprivate func handleTapGesture(sender: UITapGestureRecognizer) {
        if let action = tapGestureRecognizerAction {
            action?()
        } else {
            print("no action")
        }
    }
    
    func setupBorder(color: UIColor = .black) {
        layer.borderColor = color.cgColor
        layer.borderWidth = 1
    }
}

extension UIView {
    func roundCorners(corners: CACornerMask, radius: CGFloat) {
//        layer.masksToBounds = true
        layer.cornerRadius = radius
        layer.maskedCorners = corners
    }
    
    func cornerShape(corners: UIRectCorner, radius: CGFloat) {
        let rectShape = CAShapeLayer()
        rectShape.bounds = frame
        rectShape.position = center
        rectShape.path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius)).cgPath
        layer.mask = rectShape
    }
}

extension UIView {
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
}
