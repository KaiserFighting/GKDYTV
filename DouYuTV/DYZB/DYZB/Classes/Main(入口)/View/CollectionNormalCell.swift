//
//  CollectionNormalCell.swift
//  DYZB
//
//  Created by caesar on 2019/7/29.
//  Copyright © 2019 caesar. All rights reserved.
//

import UIKit

class CollectionNormalCell: CollectionViewBaseCell {
    // MARK:- 控件属性
    @IBOutlet weak var nameLabel: UILabel!
    
    // MARK:- 设置属性
    override var anchor : AnchorModel?{
        didSet{
            
        self.nameLabel.text = anchor?.room_name
    }
  }
}
