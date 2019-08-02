//
//  PageContentView.swift
//  DYZB
//
//  Created by caesar on 2019/7/26.
//  Copyright © 2019 caesar. All rights reserved.
//

import UIKit

protocol PageContentViewDelegate : class {
    func pageContentView(_ pageView : PageContentView, progress : CGFloat, sourceIndex : Int,targetIndex : Int)
}

private let collectionCellID = "collectionCellID"

class PageContentView : UIView {
    
    //声明代理属性
    weak var delegate : PageContentViewDelegate?
    
    fileprivate var childVcs : [UIViewController]
    //weak修改可选链
    fileprivate weak var parents : UIViewController?
    //开始偏移量
    fileprivate var startOffsetX :CGFloat = 0
    //设置禁止
    fileprivate var isForbidScroll : Bool = false
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
        collectionView.delegate = self
        
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

// MARK:- UICollectionViewDataSource
extension PageContentView : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionCellID, for: indexPath)
        for view in cell.contentView.subviews{
            view.removeFromSuperview()
        }
        
        let childVc = childVcs[indexPath.item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        
        return cell
    }
}

// MARK:- UICollectionViewDelegate
extension PageContentView : UICollectionViewDelegate {
    
    //开始拖拽
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isForbidScroll = false
        startOffsetX = scrollView.contentOffset.x
    }
    //已经滚动了
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        if isForbidScroll { return}
        
        //1.定义要获取的属性
        var progress : CGFloat = 0
        var sourceIndex : Int = 0
        var targetIndex : Int = 0
        let currentOffSetX  = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        if currentOffSetX > startOffsetX {//左滑

            //1.计算progress floor取整函数
            progress = currentOffSetX / scrollViewW - floor(currentOffSetX / scrollViewW)
            //2.获取当前的下标
            sourceIndex = Int(currentOffSetX / scrollViewW)
            //3.获取滑到页面的下标
            targetIndex = sourceIndex + 1
            if targetIndex >= childVcs.count{
                targetIndex = childVcs.count - 1
            }
            //4.滑动到目标页面的话
            if currentOffSetX - startOffsetX == scrollViewW{
                progress = 1.0;
                targetIndex = sourceIndex
            }
        }else{//右滑
            
            // 1.计算progress
            progress = 1 - (currentOffSetX / scrollViewW - floor(currentOffSetX / scrollViewW))
            // 2.计算targetIndex
            targetIndex = Int(currentOffSetX / scrollViewW)
            // 3.计算sourceIndex
            sourceIndex = targetIndex + 1
            if sourceIndex >= childVcs.count {
                sourceIndex = childVcs.count - 1
            }
        }
        //将获取的progress、sourceIndex和TargetIndex传递到pageTitleView中
//        print("progress : \(progress), sourceIndex :\(sourceIndex),targetIndex : \(targetIndex)")
        delegate?.pageContentView(self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}

// MARK:- 对外开放的接口
extension PageContentView{
    func setCurrendIndex(currendIndex : Int) {
        // 1.记录需要进制执行代理方法
        isForbidScroll = true
        // 2.滚动正确的位置
        let offsetX = CGFloat(currendIndex) * collectionView.frame.size.width
        self.collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
    
}

