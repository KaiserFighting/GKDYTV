//
//  CollectionCycleCell.swift
//  DYZB
//
//  Created by caesar on 2019/7/31.
//  Copyright © 2019 caesar. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionCycleCell: UICollectionViewCell {

    // MARK:- 控件属性
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK:- 属性赋值
    var cycleModel : CycleModel? {
        didSet {
            guard let cycleModel = cycleModel else { return }
            
            titleLabel.text = cycleModel.title
            let url = URL(string: cycleModel.pic_url ?? "")
            iconImageView.kf.setImage(with: url, placeholder: UIImage(named: "live_cell_default_phone"))
        }
    }
    
}
