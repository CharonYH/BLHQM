//
//  UILabel+Extension.swift
//  FastLook
//
//  Created by YEHAN on 2021/7/7.
//

import UIKit

extension UILabel{
    
    /// 便利构造函数
    /// - Parameters:
    ///   - text: 文本
    ///   - textColor: 文本颜色
    ///   - textAlignment: 对齐方式
    ///   - font: 字体
    ///   - frame: CGRect
    convenience init(text: String,
                     textColor: UIColor,
                     textAlignment: NSTextAlignment,
                     font: UIFont,
                     frame: CGRect) {
        
        self.init()
        self.text = text
        self.textColor = textColor
        self.textAlignment = textAlignment
        self.font = font
        self.frame = frame
    }
}
