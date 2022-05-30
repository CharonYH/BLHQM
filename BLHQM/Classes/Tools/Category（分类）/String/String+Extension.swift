//
//  String+Extension.swift
//  FastLook
//
//  Created by Charron on 2021/11/14.
//

import UIKit

extension String {
    
    /// 返回富文本
    /// - Parameters:
    ///   - fontSize: 字体大小
    ///   - lineSpacing: 字体间距
    ///   - size: 大小一般是CGSize()
    func getAtrributedStringWithFont(fontSize: CGFloat,
                                  lineSpacing:CGFloat,
                                         size: CGSize) {
        
    }
    
    /// 获取文本宽度
    /// - Parameters:
    ///   - fontSize: 字体大小
    ///   - height: 高度
    /// - Returns: 宽度
    func getWordWidth(font: UIFont,
                  height: CGFloat) -> CGFloat{
        let size = CGSize(width: CGFloat(MAXFLOAT), height: height)
        return self.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil).width
        //usesLineFragmentOrigin   一般就用这个选项,以矩形的形式计算
    }
    
    /// 获取文本size
    /// - Parameter fontSize: 字体大小
    /// - Returns: 文本size
    func getWordSize(font: UIFont) -> CGSize{
        let size = CGSize(width: CGFloat(MAXFLOAT), height: CGFloat(MAXFLOAT))
        return self.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil).size
        //usesLineFragmentOrigin   一般就用这个选项,以矩形的形式计算
    }
}

//MARK:字符串截取
extension String {
    
    /// 使用下标截取字符串 eg: "12345"[3] // 4
    /// - Parameter r: Range范围
    /// - Returns: 字符串
    subscript (i: Int) -> String {
        let startIndex = index(self.startIndex, offsetBy: i)
        let endIndex = index(startIndex, offsetBy: 1)
        return String(self[startIndex..<endIndex])
    }
    
    /// 使用下标截取字符串 eg: "12345"[1...3] // 234
    /// - Parameter r: Range范围
    /// - Returns: 字符串
    subscript (range: Range<Int>) -> String {
        get {
            let startIndex = index(startIndex, offsetBy: range.lowerBound)
            let endIndex = index(startIndex, offsetBy: range.upperBound)
            return String(self[startIndex..<endIndex])
        }
    }
    
    /// 使用下标截取字符串  eg: "1234"[1,2] // 23
    /// - Parameter index: 起始位置
    /// - Parameter length: 截取长度
    /// - Returns: 字符串
    subscript (index: Int, length: Int) -> String {
        get {
            let startIndex = self.index(self.startIndex, offsetBy: index)
            let endIndex = self.index(startIndex, offsetBy: length)
            return String(self[startIndex..<endIndex])
        }
    }
    
    
    /// 截取从头到i位置  不包括i eg: “1234”[2,2] //34
    /// - Parameter to:
    /// - Returns: 字符串
    func substring(to: Int) -> String {
        return self[0..<to]
    }
    
    /// 截取从i到尾部
    /// - Parameter from:
    /// - Returns: 字符串
    func substring(from: Int) -> String {
        return self[from..<self.count]
    }
    
    /// 截取关键字前面的（不包含关键字）
    func prefix(_ keywords: String) -> String {
        guard let range = range(of: keywords) else { return self }
        let nsRange = NSRange(range, in: keywords)
        return String(prefix(nsRange.location))
    }
    
    /// 截取关键字后面的（包含关键字）
    func suffix(_ keywords: String) -> String {
        guard let range = range(of: keywords) else { return self }
        let nsRange = NSRange(range, in: keywords)
        return String(suffix(self.count - nsRange.location - nsRange.length))
    }
}

/// 图片扩展
extension String {
    var image: UIImage? {
        return UIImage(named: self)
    }
}
