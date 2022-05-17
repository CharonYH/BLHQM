//
//  UITextFiled+Extension.swift
//  FastLook
//
//  Created by Charron on 2021/12/3.
//

import UIKit

extension UITextField {
    /// 便利构造函数
    /// - Parameters:
    ///   - text: 文本
    ///   - textColor: 文本颜色
    ///   - textAlignment: 对齐方式
    ///   - font: 字体
    ///   - frame: CGRect
    convenience init(text: String,
                     placeholder: String?,
                     textColor: UIColor,
                     textAlignment: NSTextAlignment,
                     font: UIFont,
                     frame: CGRect) {
        self.init()
        self.text = text
        self.placeholder = placeholder
        self.textColor = textColor
        self.textAlignment = textAlignment
        self.font = font
        self.frame = frame
    }
}
