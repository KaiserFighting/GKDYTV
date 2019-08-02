//
//  AnchorModel.swift
//  DYZB
//
//  Created by caesar on 2019/7/30.
//  Copyright © 2019 caesar. All rights reserved.
//

import UIKit

@objcMembers
class AnchorModel: NSObject {
   //房间ID
     var room_id : Int = 0
    //房间图片
     var vertical_src : String?
    
    //判定是手机直播还是电脑直播 0是电脑直播，1是手机直播
     var isVertical : Int = 0
    //房间名称
     var room_name : String?
    //昵称
    var nickname : String?
    //在线人数
     var online : Int = 0
    //显示城市名
    var anchor_city : String?
    
    init(dict : [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forKey key: String) {
        ///这句话很关键,一定要有
        super.setValue(value, forKey: key)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
//        print(key)
    }
}
