//
//  UIButton+Extension.swift
//  FastLook
//
//  Created by YEHAN on 2021/11/28.
//

import UIKit
extension UIButton {
    
    /// 按钮 文字 排列
    enum ButtonImagePosition {
        case top    //图片在上,文字在下 垂直居中
        case bottom //图片在下,文字在上 垂直居中
        case left   //图片在左,文字在右 水平居中
        case right  //图片在右,文字在左 水平居中
    }
    
    /// 设置图片 文字的位置 (系统默认的是:图片在左 文字在右)
    /// - Parameters:
    ///   - style: ButtonImagePosition
    ///   - space: 图片 文字间距
    func imagePositon(_ style: ButtonImagePosition, space: CGFloat) {
        /// 图片的宽度 高度
        let imageWidth = currentImage?.size.width
        let imageHeight = currentImage?.size.height
        /// 文本的宽度 高度
        let labelWidth = titleLabel?.intrinsicContentSize.width
        let labelHeight = titleLabel?.intrinsicContentSize.height
        
        var imageEdgeInsets: UIEdgeInsets = .zero
        var titleEdgeInsets: UIEdgeInsets = .zero
        
        /**
         *  默认是图片在左,文字在右
         *  上左下右
         *  image的上下左边缘是以contentView为参照,image的右边是已titleLabel的左边为参照
         *  titleLabel的上下右边缘是以contenView为参照,titleLabel的左边是已image的右边为参考
         *  具体详解参考:https://www.jianshu.com/p/4802924af6d8
         */
        switch style {
        case .top:
            imageEdgeInsets = .init(top: -(labelHeight! + space), left: 0, bottom: 0, right: -labelWidth!)
            titleEdgeInsets = .init(top: 0, left: -imageWidth!, bottom: -(imageHeight! + space), right: 0)
        case .bottom:
            imageEdgeInsets = .init(top: 0, left: 0, bottom: -(labelHeight! + space), right: -labelWidth!)
            titleEdgeInsets = .init(top: -(imageHeight! + space), left: -imageWidth!, bottom: 0, right: 0)
        case .left:
            imageEdgeInsets = .init(top: 0, left: -space / 2, bottom: 0, right: space / 2)
            titleEdgeInsets = .init(top: 0, left: space / 2, bottom: 0, right: -space / 2)
        case .right:
            imageEdgeInsets = .init(top: 0, left: labelWidth! + space, bottom: 0, right: -(labelWidth! + space))
            titleEdgeInsets = .init(top: 0, left: -(imageWidth! + space), bottom: 0, right: imageWidth! + space)
        }
        
        self.imageEdgeInsets = imageEdgeInsets
        self.titleEdgeInsets = titleEdgeInsets
    }
}
