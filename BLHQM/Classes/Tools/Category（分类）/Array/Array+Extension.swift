//
//  Array+Extension.swift
//  FastLook
//
//  Created by Charron on 2021/11/28.
//

import Foundation
extension Array where Element: Comparable {
    
    /// 比较两个数组是否相等
    /// - Parameter other: 另一个数组
    /// - Returns: 是否相等
    func containsSameElemens(as other: [Element]) -> Bool {
        return self.count == other.count && self.sorted() == other.sorted()
    }
}
