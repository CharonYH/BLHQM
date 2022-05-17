//
//  BLHTopTabsService.swift
//  BLHDemo
//
//  Created by XiaoBai on 2022/5/8.
//


import Foundation
import Moya
import HandyJSON
import SwiftyJSON

enum HomeAPI {
    case topTabs
    case tj //推荐
    case qm //拼音启蒙
    case eg // 儿歌
    case dh //动画
    case hb //绘本
    case english //英语专区
}
extension HomeAPI: TargetType {
    var baseURL: URL {
        return .init(string: "https://vd.ubestkid.com/api/v1/")!
    }
    
    var path: String {
        switch self {
        case .topTabs:
            return "feature/getTopTabs/qm_home6/"
            
        case .tj:
            return "featureV2/qmtab_tj_508.json"
        case .qm:
            return "featureV2/6xo2fn1650529203821.json"
        case .eg:
            return "featureV2/qmtab_eg_508.json"
        case .dh:
            return "featureV2/qmtab_dh_508.json"
        case .hb:
            return "featureV2/qmtab_hb_508.json"
        case .english:
            return "featureV2/9beq2o1648520345372.json"
        }
        
    }
    
    var method: Moya.Method {
        switch self {
        case .topTabs,
                .tj,
                .qm,
                .eg,
                .dh,
                .hb,
                .english: return .post
        }
    }
    
    var task: Task {
        switch self {
        case .topTabs:
            let parameters:[String:Any] = HomeDatasProvider.homeTopTabs
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case .tj:
            let parameters:[String:Any] = HomeDatasProvider.tj
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case .qm:
            let parameters:[String:Any] = HomeDatasProvider.qm
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case .eg:
            let parameters:[String:Any] = HomeDatasProvider.eg
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case .dh:
            let parameters:[String:Any] = HomeDatasProvider.dh
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case .hb:
            let parameters:[String:Any] = HomeDatasProvider.hb
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case .english:
            let parameters:[String:Any] = HomeDatasProvider.english
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? { nil }
    
}

extension MoyaProvider {
    
    @discardableResult
    func send<T: HandyJSON >(_ target: Target,
                 modelType: T.Type,
                 completion: ((T?) -> ())?) -> Cancellable {
        return request(target) { result in
            // 没有回调处理 则直接返回
            guard let completion = completion else {
                return
            }
            
            switch result {
            case let .success(response):
                print("json = \(try! JSONSerialization.jsonObject(with: response.data))")
                if let json = JSON(response.data).dictionaryObject,
                   let res = modelType.deserialize(from: json) {
                    completion(res)
                }
            case .failure(_):
                completion(nil)
            }
        }
    }
}
