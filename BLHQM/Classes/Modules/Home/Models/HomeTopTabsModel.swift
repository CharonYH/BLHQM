//
//  TopTabsModel.swift
//  BLHDemo
//
//  Created by XiaoBai on 2022/5/8.
//

import Foundation
import HandyJSON

//struct HomeBaseModel<T: HandyJSON>: HandyJSON {
//    var errorMessage: String = ""
//    var errorCode: Int = -1
//    var result: [T]?
//}

/// 首页上方TopTabs
struct HomeTopTabsModel: HandyJSON {
    var errorMessage: String = ""
    var errorCode: Int = -1
    var result: [TabModels] = []
    
    struct TabModels: HandyJSON {
        var tabSlot: String = ""
        var tabName: String = ""
        var bannerType: String = ""
        var backColor: String = ""
        var tabTitle: String = ""
    }
}
