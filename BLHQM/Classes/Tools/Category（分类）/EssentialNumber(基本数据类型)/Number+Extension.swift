//
//  Int+Extension.swift
//  BLHQM
//
//  Created by XiaoBai on 2022/5/17.
//

import Foundation
// MARK: - Int
extension Int {
    var layoutFit: CGFloat {
        return CGFloat(self)*RATIO_WIDHT750
    }
}
// MARK: - Double
extension Double {
    var layoutFit: CGFloat {
        return CGFloat(self)*RATIO_WIDHT750
    }
}

// MARK: - Float
extension Float {
    var layoutFit: CGFloat {
        return CGFloat(self)*RATIO_WIDHT750
    }
}
