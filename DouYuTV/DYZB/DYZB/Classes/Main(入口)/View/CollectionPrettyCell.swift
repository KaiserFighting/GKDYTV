//
//  CollectionPrettyCell.swift
//  DYZB
//
//  Created by caesar on 2019/7/29.
//  Copyright © 2019 caesar. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionPrettyCell: CollectionViewBaseCell {
    
    // MARK:- 控件属性
    @IBOutlet weak var cityBtn: UIButton!
    // MARK:- 设置属性
   override var anchor : AnchorModel?{
        didSet{
            //城市名称
            self.cityBtn .setTitle(anchor?.anchor_city, for: .normal)
        }
    }
}
