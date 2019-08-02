//
//  AnchorGroupModel.swift
//  DYZB
//
//  Created by caesar on 2019/7/30.
//  Copyright © 2019 caesar. All rights reserved.
//

import UIKit

@objcMembers
class AnchorGroupModel : BaseGameModel {
    
    lazy var anchors : [AnchorModel] =  [AnchorModel]()
 //编译器不再自动推断，你必须显式添加@objc OC的方法
    //该组中对应的房间信息
    var  room_list : [[String : Any]]? {
        //属性监听器
        didSet{
            guard let room_list = room_list else { return }
            
            for dict in room_list{
                anchors.append(AnchorModel(dict: dict))
            }
        }
    }
    //组显示的图标
    var icon_name : String?
    
}
