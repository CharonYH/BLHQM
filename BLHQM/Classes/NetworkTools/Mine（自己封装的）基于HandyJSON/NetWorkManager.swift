//
//  NetWorkManager.swift
//  BLHDemo
//
//  Created by XiaoBai on 2022/5/7.
//

import Foundation
import HandyJSON
import SwiftyJSON

enum YHRequestMethod: String {
    case GET,POST
}

/// 请求接口，定义请求的路径、参数，响应类型
protocol YHRequest {
    var baseURL: String { get }
    var path: String { get }
    var parameters: [String:Any] { get }
    var method: YHRequestMethod { get }
    associatedtype Response: YHDecodable
    
}
/// 执行具体的请求
protocol YHClient {
    func request<T: YHRequest>(_ req: T,
                          completion: @escaping (T.Response?) -> ())
}

/// 解码
protocol YHDecodable: HandyJSON {
   static func parase(_ data: Data) -> Self?
}
// 解码的默认实现
extension YHDecodable {
   static func parase(_ data: Data) -> Self? {
        if let dict = try? JSONSerialization.jsonObject(with: data) as? [String:Any] {
            return Self.deserialize(from: dict)
        }
        return nil
    }
}

struct YHNetWorkManager: YHClient {
    static let shared = YHNetWorkManager()
    
    func request<T>(_ req: T, completion: @escaping (T.Response?) -> ()) where T : YHRequest {
        let path = req.baseURL + req.path
        let url = URL(string: path)!
        var request = URLRequest(url: url)
        request.httpMethod = req.method.rawValue
        
        URLSession.shared.dataTask(with: request) { data, res, error in
            guard let data = data,
                  let response = T.Response.parase(data) else {
                
                completion(nil)
                return
            }
            completion(response)
        }.resume()
    }
}
