//
//  UIView+Extension.swift
//  FastLook
//
//  Created by Charron on 2021/8/10.
//

import UIKit
extension UIView {
    
    
    ///手势种类
    enum GestureRecognizerKind: Int {
        case tap        //轻点
        case pintch     //捏合
        case rotation   //旋转
        case swipe      //轻扫
        case pan        //拖拽
        case screen     //屏幕边缘滑动
        case long       //长按
    }
        
    /// 给view添加手势
    /// - Parameters:
    ///   - gestureKind: 手势种类
    ///   - target: 事件持有对象
    ///   - action: Selector
    func addGesture(gestureKind: GestureRecognizerKind,
                    target: Any?,
                    action: Selector?) {
        var gesture: UIGestureRecognizer! = nil
        switch gestureKind {
            case .tap:
                gesture = UITapGestureRecognizer(target: target, action: action)
            case .pintch:
                gesture = UIPinchGestureRecognizer(target: target, action: action)
            case .rotation:
                gesture = UIRotationGestureRecognizer(target: target, action: action)
            case .swipe:
                gesture = UISwipeGestureRecognizer(target: target, action: action)
            case .pan:
                gesture = UIPanGestureRecognizer(target: target, action: action)
            case .screen:
                gesture = UIScreenEdgePanGestureRecognizer(target: target, action: action)
            case .long:
                gesture = UILongPressGestureRecognizer(target: target, action: action)
        }
        isUserInteractionEnabled = true
        addGestureRecognizer(gesture)
    }
    
    
    /// 获取View子控件中imgview
        /// - Parameter view: <#view description#>
        /// - Returns: <#description#>
        func findNavLineView() -> UIImageView? {
            if self.isKind(of: UIImageView.self) && self.frame.height <= 1.0 {
                return self as? UIImageView
            }
            for subView in self.subviews {
                let imageView = subView.findNavLineView()
                if imageView != nil {
                    return imageView
                }
            }
            return nil
        }
    
    /// 获取当前UIView所在的控制器
    var currentVC: UIViewController? {
        for view in sequence(first: superview, next: { $0?.superview }) {
            if let responder = view?.next,responder.isKind(of: UIViewController.self) {
                return responder as? UIViewController
            }
        }
        return nil
    }
}

//MARK: 动画
extension UIView {
    
    /// 动画渐变色（变灰色）
    public static func animateGray(with view: UIView, duration: TimeInterval = 0.45) {
        UIView.animate(withDuration: duration) {
            view.backgroundColor = RGBColorHex(s: 0x000000)
            view.alpha = 0.65
        }
    }
    /// 恢复
    public static func animateOrigin(with view: UIView, duration: TimeInterval = 0.45) {
        UIView.animate(withDuration: 0.45) {
            view.alpha = 0
            view.backgroundColor = RGBColorHex(s: 0xFFFFFF)
        } completion: { finished in
            view.removeFromSuperview()
        }
    }
}

// MARK: Properties(xib SB)
@IBDesignable
extension UIView {
    @IBInspectable
    /// Should the corner be as circle
    public var circleCorner: Bool {
        get {
            return min(bounds.size.height, bounds.size.width) / 2 == cornerRadius
        }
        set {
            cornerRadius = newValue ? min(bounds.size.height, bounds.size.width) / 2 : cornerRadius
        }
    }
    
    @IBInspectable
    /// Corner radius of view; also inspectable from Storyboard.
    public var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = circleCorner ? min(bounds.size.height, bounds.size.width) / 2 : newValue
            //abs(CGFloat(Int(newValue * 100)) / 100)
            maskToBounds = true
        }
    }
    
    @IBInspectable
    /// Border color of view; also inspectable from Storyboard.
    public var borderColor: UIColor? {
        get {
            guard let color = layer.borderColor else {
                return nil
            }
            return UIColor(cgColor: color)
        }
        set {
            guard let color = newValue else {
                layer.borderColor = nil
                return
            }
            layer.borderColor = color.cgColor
        }
    }
    
    @IBInspectable
    /// Border width of view; also inspectable from Storyboard.
    public var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    /// Shadow color of view; also inspectable from Storyboard.
    public var shadowColor: UIColor? {
        get {
            guard let color = layer.shadowColor else {
                return nil
            }
            return UIColor(cgColor: color)
        }
        set {
            layer.shadowColor = newValue?.cgColor
        }
    }
    
    @IBInspectable
    /// Shadow offset of view; also inspectable from Storyboard.
    public var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    /// Shadow opacity of view; also inspectable from Storyboard.
    public var shadowOpacity: Double {
        get {
            return Double(layer.shadowOpacity)
        }
        set {
            layer.shadowOpacity = Float(newValue)
        }
    }
    
    @IBInspectable
    /// Shadow radius of view; also inspectable from Storyboard.
    public var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    /// Shadow path of view; also inspectable from Storyboard.
    public var shadowPath: CGPath? {
        get {
            return layer.shadowPath
        }
        set {
            layer.shadowPath = newValue
        }
    }
    
    @IBInspectable
    /// Should shadow rasterize of view; also inspectable from Storyboard.
    /// cache the rendered shadow so that it doesn't need to be redrawn
    public var shadowShouldRasterize: Bool {
        get {
            return layer.shouldRasterize
        }
        set {
            layer.shouldRasterize = newValue
        }
    }
    
    @IBInspectable
    /// Should shadow rasterize of view; also inspectable from Storyboard.
    /// cache the rendered shadow so that it doesn't need to be redrawn
    public var shadowRasterizationScale: CGFloat {
        get {
            return layer.rasterizationScale
        }
        set {
            layer.rasterizationScale = newValue
        }
    }
    
    @IBInspectable
    /// Corner radius of view; also inspectable from Storyboard.
    public var maskToBounds: Bool {
        get {
            return layer.masksToBounds
        }
        set {
            layer.masksToBounds = newValue
        }
    }
    
    @IBInspectable
    public var bgImage: UIImage? {
        set {
            if let img = newValue {
                self.layer.contents = img.cgImage
            }
        }
        get {
            if let cgImage = self.layer.contents {
                return UIImage(cgImage: cgImage as! CGImage )
            }
            
            return nil
        }
    }
}
