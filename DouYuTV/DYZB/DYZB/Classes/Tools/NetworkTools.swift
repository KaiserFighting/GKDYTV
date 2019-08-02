//
//  NetworkTools.swift
//  DYZB
//
//  Created by caesar on 2019/7/29.
//  Copyright © 2019 caesar. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
    case get
    case post
}

class NetworkTools {

    class func requestData(type : MethodType , url : String,paramerters : [String : Any]? = nil , finishdCallBack: @escaping (_ result : Any)-> ()){
        
        //1.获取类型
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        //2.发送请求
        AF.request(url, method: method, parameters: paramerters, encoding: URLEncoding.default, headers: nil, interceptor: nil).responseJSON { (response) in
            //3.获取结果
            guard let result = response.value else{
                print(response.error!)
                return
            }
            //4.将结果回调
            finishdCallBack(result)
        }
    }
}
