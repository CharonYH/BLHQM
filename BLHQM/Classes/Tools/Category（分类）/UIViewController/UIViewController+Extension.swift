//
//  UIViewController+Extension.swift
//  BLHQM
//
//  Created by XiaoBai on 2022/5/15.
//

import Foundation
import UIKit

extension UIViewController {
    
    /// 适配UIScrollView
    /// - Parameter scrollView: UIScrollView
    func adjustScrollViewInsets(_ scrollView: UIScrollView) {
        if #available(iOS 11, *) {
            scrollView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
    }
}
