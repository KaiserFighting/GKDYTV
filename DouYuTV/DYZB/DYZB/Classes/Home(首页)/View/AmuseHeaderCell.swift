//
//  AmuseHeaderCell.swift
//  DYZB
//
//  Created by caesar on 2019/8/1.
//  Copyright © 2019 caesar. All rights reserved.
//

import UIKit

private let kGameCellID = "kGameCellID"

class AmuseHeaderCell: UICollectionViewCell {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var groups : [AnchorGroupModel]?{
        didSet {
            
            collectionView.reloadData()
        }
    }
    
    // MARK:- 从xib加载出来
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //注册cell
        collectionView.register(UINib.init(nibName: "CollectionGameViewCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        //流水布局
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let itemW = self.bounds.width / 4
        let itemH = self.bounds.height / 2
        layout.itemSize = CGSize(width: itemW, height: itemH)
    }
}

extension AmuseHeaderCell : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! CollectionGameViewCell
        cell.clipsToBounds = true
        cell.group = groups?[indexPath.item]
        
        return cell
    }
}
