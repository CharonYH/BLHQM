//
//  UIBezierPath+Extension.swift
//  FastLook
//
//  Created by YEHAN on 2021/7/7.
//

import UIKit

extension UIBezierPath {
    
    
    /// 给View切圆角
    /// - Parameters:
    ///   - view: 待切圆角的view
    ///   - cornerType: 圆角类型
    ///   - size: 圆角半径
    static func roundedView(view: UIView,cornerType: UIRectCorner, size:CGSize) {
        let bezierPath = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: cornerType, cornerRadii: size)
        let layer = CAShapeLayer()
        layer.path = bezierPath.cgPath
        layer.frame = view.bounds
        view.layer.mask = layer
    }
}
