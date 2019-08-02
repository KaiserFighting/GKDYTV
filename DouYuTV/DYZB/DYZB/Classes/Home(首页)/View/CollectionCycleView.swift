//
//  CollectionCycleView.swift
//  DYZB
//
//  Created by caesar on 2019/7/31.
//  Copyright © 2019 caesar. All rights reserved.
//

import UIKit

private let cycleCollectionCellID = "cycleCollectionCellID"

class CollectionCycleView: UIView {
    // MARK:- 控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageViewController: UIPageControl!
    
    // MARK:- 定义属性
    var cycleTimer: Timer?
    var cycleModels : [CycleModel]? {
       didSet {
           collectionView.reloadData()
           pageViewController.numberOfPages = cycleModels?.count ?? 0
        
           //滚动到中间的某个位置
           let indexPath = NSIndexPath(item: (cycleModels?.count ?? 0) * 10, section: 0)
            collectionView.scrollToItem(at: indexPath as IndexPath, at: UICollectionView.ScrollPosition.left, animated: false)
            //添加定时器
            removeCycleTimer()
            addCycleTimer()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 设置该控件不随着父控件的拉伸而拉伸
        autoresizingMask =  UIView.AutoresizingMask()
        
        //注册cell
        collectionView.register(UINib.init(nibName: "CollectionCycleCell", bundle: nil), forCellWithReuseIdentifier: cycleCollectionCellID)
    
//        layout.itemSize = collectionView.bounds.size 这里获取的collectionView.bounds.size是Xib中的尺寸
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //布局
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
    }
    
}

// MARK:- 创建轮播图
extension CollectionCycleView {
    
    class func creatCycleView() -> CollectionCycleView {
        return Bundle.main.loadNibNamed("CollectionCycleView", owner: nil, options: nil)?.first as! CollectionCycleView
    }
    
    
}

// MARK:- 遵循UICollectioViewDataSource协议
extension CollectionCycleView : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (cycleModels?.count ?? 0) * 10000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cycleModel = cycleModels?[(indexPath as IndexPath).item % cycleModels!.count]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cycleCollectionCellID, for: indexPath) as! CollectionCycleCell

        cell.cycleModel = cycleModel
        
        return cell
    }

    
}

// MARK:- 遵守UICollectionViewDelagate协议
extension CollectionCycleView : UICollectionViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offsetX = scrollView.contentOffset.x + scrollView.bounds.size.width * 0.5
        //设置当前的页数
        pageViewController.currentPage = Int(offsetX / scrollView.bounds.size.width) % (cycleModels?.count ?? 1)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeCycleTimer()
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        addCycleTimer()
    }
    
}

// MARK:- 对定时器的操作方法
extension CollectionCycleView {
    
    //创建定时器
    fileprivate func addCycleTimer() {
        cycleTimer = Timer(timeInterval: 3.0, target: self, selector: #selector(self.scrollToNext), userInfo: nil, repeats: true)
        //加入到runloop中
        RunLoop.main.add(cycleTimer!, forMode: .common)
    }
    //移除定时器
    fileprivate func removeCycleTimer(){
        cycleTimer?.invalidate()
        cycleTimer = nil
    }
    
    //滚动到下一个
    @objc fileprivate func scrollToNext(){
        
        let currentOffsetX =  collectionView.contentOffset.x
        let offsetX = currentOffsetX + collectionView.bounds.width
        
        //滚动到指定位置
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
    
}

