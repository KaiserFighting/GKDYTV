//
//  CollectionHaderView.swift
//  DYZB
//
//  Created by caesar on 2019/7/29.
//  Copyright © 2019 caesar. All rights reserved.
//

import UIKit

class CollectionHaderView: UICollectionReusableView {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleNameLabel: UILabel!
    @IBOutlet weak var moreBtn: UIButton!
    
    // MARK:- 定义模型数据
     var anchor : AnchorGroupModel?{
        didSet{
            titleNameLabel.text = anchor?.tag_name
            iconImageView.image = UIImage(named: anchor?.icon_name ?? "home_header_normal")
        }
    }
}
// MARK:- 创建类方法，从xib中加载
extension CollectionHaderView {
   class func crertCollectionViewClassMethod() -> CollectionHaderView {
        
        return Bundle.main.loadNibNamed("CollectionHaderView", owner: nil, options: nil)?.first as! CollectionHaderView
    }
    
}

