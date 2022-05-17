//
//  BLHBaseModel.swift
//  BLHDemo
//
//  Created by XiaoBai on 2022/5/8.
//

import UIKit
import HandyJSON

/// 首页基本数据模型
struct HomeModel: HandyJSON {
    var icon_items: [HomeItemModel] = []
    var more_items: [HomeItemModel] = []
    var top_items: [HomeItemModel] = []
    var version = 0
}


struct HomeItemChildDatas: HandyJSON {
    var aicLesson: [String:Any] = [:]
    var cateId = 0
    var cateType = 0
    var count = 0
    var detailImages = ""
    var hasJiaoju = 0
    var hot = 0
    var icon: String?
    var id = 0
    var image = ""
    var image16x9 = ""
    var image2 = ""
    var image23x8 = ""
//    var interactLesson
//    var items
//    var knowImages
    var mediaType = ""
    var memberFree = 0
    var memberPrice = 0
    var parentZl = 0
    var progressNs = ""
    var publish = 0
    var saleTitle = ""
    var studyCount = 0
    var tags = ""
    var tags2 = ""
    var totalCount = 0
    var userProgressSum = 0
    var video: String?
}
struct HomeItemDatas: HandyJSON {
    var bannercover = ""
    var brandcover = ""
    var cacheexpire: Int?
    var catetype = 0
    var channelid = 0
    var count = 0
    var countrycode = 0
    var desc: String?
    var game = 0
    var hot = 0
    var icon = ""
    var image21 = ""
    var items:[HomeItemChildDatas] = []
    var largecover = ""
    var lastpdate: String?
    var memberFree = 0
    var pid: String?
    var product: String?
    var progressNs: String?
    var promotion: String?
    var publish = 0
    var subcateid = 0
    var subcatename = ""
    var subcatename2 = ""
//            var tags: []
    var tags2 = ""
    var totalCount = 0
    var userProgressSum = 0
}

struct HomeItemModel: HandyJSON {
    
    var actionType = ""
    var actionValue = ""
    var contentId = 0
    var contentType = ""
    var data: HomeItemDatas = .init()
    var hasItems = 0
    var id = 0
    var title = ""
    var viewParams = "" // 字符串：实际上是一个json字符串
    var viewType = ""
    
    // 将viewParams -> ViewParams
    var viewP: ViewParams {
        var paramas = ViewParams()
        guard let data = viewParams.data(using: .utf8),
              let dict = try? JSONSerialization.jsonObject(with: data) as? [String:Any] else {
            return paramas
        }
        if let p = ViewParams.deserialize(from: dict) {
            paramas = p
        }
        return paramas
    }
    // 布局方式
    var layoutType: LayoutType {
        switch (contentType,viewType) {
            /**
             1.("VIDEO_CATE", "SQUARE")
             2.("XT_ZL","LIST")          阅读与表达启蒙
             3.("VIDEO", "SQUARE")       嗨！贝乐虎情商培养
             4.("XT_ZL", "BIG")          宝宝都在看
             5.("INTER_LESSON", "BIG_LIST")
             6.("HB_BOOK", "SLIDE")
             */
            /**
             热门动画榜 儿童专区 贝乐虎入园记 嗨！贝乐虎情商培养(根据viewParamas来) 汉字练习(根据viewParamas来)
             英文儿歌磨耳朵(根据viewParamas来)
             经典故事(根据viewParamas来)
             */
        case ("VIDEO_CATE", "SQUARE"),("VIDEO", "SQUARE"):
            return .hot
            // 阅读与表达启蒙 精品互动视频
        case ("XT_ZL","LIST"):
            return .list
            // 宝宝都在看 培养英语基础
        case ("XT_ZL", "BIG") :
            return .big
            //        case ("VIDEO", "SQUARE"), ("VIDEO", "FOCUS"):
            //            return .video
            //        case ("VIDEO_SINGLE", "FOCUS"):
            //            return .video_player
            //        case ("XT_ZL", "BIG"):
            //            return .big
            // 互动启蒙 :益智练习
        case ("INTER_LESSON", "BIG_LIST"):
            return .big_list
            // 我和恐龙交朋友 看绘本学成语
        case ("HB_BOOK", "SLIDE"):
            return .slide
            //        case ("HB_BOOK", "SQUARE"):
            //            return .book
            //        case ("AUDIO_CATE", "SQUARE"), ("AUDIO_CATE", "ICON"):
            //            return .store
            //        case ("AUDIO_CATE", "LIST"):
            //            return .store_list
            //        case ("URL", "ICON"):
            //            return .vip
            //        case ("AUDIO_ALBUM", "FOCUS"):
            //            return .audio_list
            //        default:
            //            return .video
        default: return .video
        }
    }
    enum LayoutType {
        case hot
        case list
        case big
        case big_list
        case slide
        case video
//        case book
//        case store
//        case store_list
//        case vip
//        case video_player
//        case audio_list
    }
    struct ViewParams: HandyJSON {
        var itemCount: Int = 0
        var showHeader: Int = 0
        var focusUrl: String = ""
        var iconUrl: String = ""
    }
}
