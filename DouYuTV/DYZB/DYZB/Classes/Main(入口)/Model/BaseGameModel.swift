//
//  BaseGameModel.swift
//  DYZB
//
//  Created by caesar on 2019/8/1.
//  Copyright © 2019 caesar. All rights reserved.
//

import UIKit

@objcMembers
class BaseGameModel: NSObject {
    var tag_name : String?
    var icon_url : String?
    
    // MARK:- 构造函数
    override init() {
    }
    
    // MARK:- 自定义构造函数
    init(dict : [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
    
}
