//
//  PetRequest.swift
//  BLHDemo
//
//  Created by XiaoBai on 2022/5/7.
//
import Foundation
import HandyJSON

struct Pet: YHDecodable {
    var data:[String:Any] = [:]
    
}

struct PetRequest: YHRequest {
    let petId: String
    
    let baseURL = "http://127.0.0.1:4523/mock/598630/"
    
    var path: String {
        "pet/" + petId
    }
    
    var parameters: [String : Any] = [:]
    
    var method: YHRequestMethod = .GET
    
    typealias Response = Pet
    
   
}

/// 例子
//YHNetWorkManager.shared.request(PetRequest(petId: "1")) { pet in
//    print(123)
//}
