//
//  CollectionViewBaseCell.swift
//  DYZB
//
//  Created by caesar on 2019/7/31.
//  Copyright © 2019 caesar. All rights reserved.
//

import UIKit

class CollectionViewBaseCell: UICollectionViewCell {
    
    @IBOutlet weak var sourceImageView: UIImageView!
    @IBOutlet weak var onlineBtn: UIButton!
    @IBOutlet weak var nickLabel: UILabel!
    
    // MARK:- 设置属性
    var anchor : AnchorModel?{
        didSet{
            guard let anchor = anchor else{return}
            self.nickLabel.text = anchor.nickname
            var onlineStr = ""
            if anchor.online >= 10000 {
                onlineStr = "\(Int(anchor.online / 10000 ))人在线"
            }else{
                onlineStr = "\(anchor.online)在线"
            }
            self.onlineBtn.setTitle(onlineStr, for: .normal)
            let urlStr = URL(string: anchor.vertical_src ?? "Img_default")
            self.sourceImageView.kf.setImage(with: urlStr, placeholder:UIImage(named: "Img_default"))
        }
    }
}
