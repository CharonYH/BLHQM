//
//  BLHRecommendModel.swift
//  BLHDemo
//
//  Created by XiaoBai on 2022/5/8.
//

import UIKit

/// 首页推荐
struct HomeTjModel: HandyJSON {
    var errorMessage: String = ""
    var errorCode: Int = -1
    var result: HomeModel?
}
