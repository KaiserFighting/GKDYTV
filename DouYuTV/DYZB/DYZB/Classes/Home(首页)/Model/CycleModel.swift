//
//  CycleModel.swift
//  DYZB
//
//  Created by caesar on 2019/7/31.
//  Copyright © 2019 caesar. All rights reserved.
//

import UIKit

@objcMembers
class CycleModel: NSObject {
    
    var title : String?
    var pic_url : String?
    //转化成对象模型
    var room : [String : Any]? {
        didSet{
            guard let room = room else { return }
            anchor = AnchorModel(dict: room)
        }
    }
    
    //主播对象模型
    var anchor : AnchorModel?
    
    init(dict : [String : Any]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
}
