//
//  PageContentView.swift
//  DYZB
//
//  Created by caesar on 2019/7/26.
//  Copyright © 2019 caesar. All rights reserved.
//

import UIKit

private let collectionCellID = "collectionCellID"

protocol PageContentViewDelegate {
    func pageContentView(_ pageView : PageContentView, currentIndex : Int)
}


class PageContentView : UIView {
    
    //声明代理属性
//    weak var delegate : PageContentViewDelegate?
    
    fileprivate var childVcs : [UIViewController]
    //weak修改可选链
    fileprivate weak var parents : UIViewController?
    
    //使用了self，造成了循环引用
    fileprivate lazy var collectionView : UICollectionView = {[weak self] in
        
        let layout = UICollectionViewFlowLayout.init()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        
       let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.bounces = false
        collectionView.isPagingEnabled = true
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: collectionCellID)
        collectionView.dataSource = self
        
        return collectionView
    }()
    
    //创建构造函数
     init(frame: CGRect,childVcs : [UIViewController], parentVc : UIViewController?) {
        self.childVcs = childVcs
        self.parents = parentVc
        
        super.init(frame: frame)
        
        //设置UI
        setupUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension PageContentView{
    
    private func setupUI(){
        //1.将子控制器添加到父控制器上面
        for childVc in childVcs{
            parents?.addChild(childVc)
        }
        
        //2.添加UIcollectionView，用于在cell存放控制器的view
        addSubview(collectionView)
        collectionView.frame = bounds
    }
}

// MARK:- UICollectionViewDelgate
extension PageContentView : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionCellID, for: indexPath)
        for view in cell.contentView.subviews{
            view.removeFromSuperview()
        }
        
        let Vc = childVcs[indexPath.item]
        cell.contentView.addSubview(Vc.view)
        return cell
    }
    
}

// MARK:- 对外开放的接口
extension PageContentView{
    
    func setCurrendIndex(currendIndex : Int) {
        let offsetX = CGFloat(currendIndex) * collectionView.frame.size.width
        self.collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
}

