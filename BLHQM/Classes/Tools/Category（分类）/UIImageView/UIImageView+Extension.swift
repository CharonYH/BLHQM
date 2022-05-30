//
//  UIImageView+Extension.swift
//  FastLook
//
//  Created by YEHAN on 2021/7/11.
//

import UIKit

extension UIImageView {
    /**
     快速创建UIImageView（带点击事件）
     - Parameters:
     - imageName: 图片名称
     - target: 事件持有者
     - action: 事件
     - frame: frame
     */
    convenience init(imageName: String,
                     target: Any?,
                     action: Selector?,
                     frame: CGRect ){
        self.init()
        self.addGesture(gestureKind: .tap, target: target, action: action)
        image = UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal)
    }
}

// MARK: - SDWebImage

extension UIImageView {
    func yh_setImage(with url: String,
                     placeholderImage: UIImage? = nil) {
        sd_setImage(with: .init(string: url), placeholderImage: placeholderImage)
    }
}
