//
//  ViewController.swift
//  BLHDemo
//
//  Created by XiaoBai on 2022/5/7.
//

import UIKit
import Moya

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let provider = MoyaProvider<HomeAPI>()
         //首页上面tabs
        provider.send(.topTabs, modelType: HomeTopTabsModel.self) { topModel in
            if let topModel = topModel {
                print(topModel)
            }
        }

    }
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        let provider = MoyaProvider<HomeAPI>()
//
//         //首页上面tabs
//        provider.send(.topTabs, modelType: HomeTopTabsModel.self) { topModel in
//            if let topModel = topModel {
//                print(topModel)
//            }
//        }
//        
//         //推荐
//        provider.send(.tj, modelType: HomeTjModel.self) { recommendModel in
//            if let recommendModel = recommendModel {
//                print(recommendModel)
//            }
//        }
//        
//         //启蒙
//        provider.send(.qm, modelType: HomeQmModel.self) { recommendModel in
//            if let recommendModel = recommendModel {
//                print(recommendModel)
//            }
//        }
//
//         //儿歌
//        provider.send(.eg, modelType: HomeEgModel.self) { recommendModel in
//            if let recommendModel = recommendModel {
//                print(recommendModel)
//            }
//        }
//        
//        // 看动画
//        provider.send(.dh, modelType: HomeDhModel.self) { recommendModel in
//            if let recommendModel = recommendModel {
//                print(recommendModel)
//            }
//        }
//        
//
//        // 读绘本
//        provider.send(.dh, modelType: HomeHbModel.self) { recommendModel in
//            if let recommendModel = recommendModel {
//                print(recommendModel)
//            }
//        }
//        
//        // 英语专区
//        provider.send(.english, modelType: HomeEnglishModel.self) { recommendModel in
//            if let recommendModel = recommendModel {
//                print(recommendModel)
//            }
//        }
//    }
}

