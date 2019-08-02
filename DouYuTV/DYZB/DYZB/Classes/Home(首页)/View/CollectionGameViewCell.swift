//
//  CollectionGameViewCell.swift
//  DYZB
//
//  Created by caesar on 2019/7/31.
//  Copyright © 2019 caesar. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionGameViewCell: UICollectionViewCell {

    // MARK:- 控件属性
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var iconImageview: UIImageView!
    @IBOutlet weak var line: UIView!
    
    var group : BaseGameModel?{
        didSet{
            guard let group = group else { return }
            titleLabel.text =  group.tag_name
            let url = URL(string: group.icon_url ?? "")
            iconImageview.kf.setImage(with: url, placeholder: UIImage(named: "home_more_btn"))
        }
    }
    
    // MARK:- 系统的回调
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.bringSubviewToFront(line)
    }

}
