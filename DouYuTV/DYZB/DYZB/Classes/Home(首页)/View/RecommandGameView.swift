//
//  RecommandGameView.swift
//  DYZB
//
//  Created by caesar on 2019/7/31.
//  Copyright © 2019 caesar. All rights reserved.
//

import UIKit

private let gameCollectionCellID = "gameCollectionCellID"
private let kEdgeInsets : CGFloat = 10

class RecommandGameView: UIView {

    // MARK:- 控件属相
    @IBOutlet weak var collectionView: UICollectionView!
    
    var groups : [BaseGameModel]?{
        didSet{
            
            collectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // 设置该控件不随着父控件的拉伸而拉伸
        autoresizingMask =  UIView.AutoresizingMask()
        
        //注册cell
        collectionView.register(UINib.init(nibName: "CollectionGameViewCell", bundle: nil), forCellWithReuseIdentifier: gameCollectionCellID)
        //设置collectionView的内边距
        collectionView.contentInset = UIEdgeInsets(top: 0, left: kEdgeInsets, bottom: 0, right: kEdgeInsets)
    }
    
}

// MARK:- 创建类方法
extension RecommandGameView {
    
   class  func creatRecommandGameView() -> RecommandGameView {
        
        return Bundle.main.loadNibNamed("RecommandGameView", owner: nil, options: nil)?.first as! RecommandGameView
    }
}

// MARK:- 遵守UICollectionViewDataSource协议
extension RecommandGameView : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return groups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: gameCollectionCellID, for: indexPath) as! CollectionGameViewCell
        
        let group = groups?[indexPath.item]
        cell.group = group
        
        return  cell
    }

}




