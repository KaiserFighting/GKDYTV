//
//  AmuseMenuView.swift
//  DYZB
//
//  Created by caesar on 2019/8/1.
//  Copyright © 2019 caesar. All rights reserved.
//

import UIKit

private let kmenuViewCellID = "kmenuViewCellID"

class AmuseMenuView: UIView {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageController: UIPageControl!
    
    var groups : [AnchorGroupModel]? {
        didSet{
         collectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //不随着父类的拉伸而拉伸
        self.autoresizingMask = UIView.AutoresizingMask()
        
        collectionView.register(UINib.init(nibName: "AmuseHeaderCell", bundle: nil), forCellWithReuseIdentifier: kmenuViewCellID)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
    }
}

extension AmuseMenuView {
    
    class func creatMenuView() -> AmuseMenuView {
        
        return Bundle.main.loadNibNamed("AmuseMenuView", owner: nil, options: nil)?.first as! AmuseMenuView
    }
    
}

extension AmuseMenuView : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         //得到是显示几页
        if groups == nil {return 0}
        let pageNum = (groups!.count - 1) / 8 + 1
        pageController.numberOfPages = pageNum
        
        return pageNum
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kmenuViewCellID, for: indexPath) as! AmuseHeaderCell
        
        setupCellDataWithCell(cell: cell, indexPath: indexPath)
        return cell
    }
    
    private func setupCellDataWithCell(cell : AmuseHeaderCell , indexPath : IndexPath){
        //第0页 :  0~7个数据
        //第1页 : 8 ~ 15
        //第2页 : 16 ~ 23
        
        //获取起始的下标
        let startIndex = indexPath.item * 8
        //获取结束的下标
        var endIndex = (indexPath.item + 1) * 8 - 1
        
        //判定越界问题
        if endIndex > groups!.count - 1 {
            endIndex = groups!.count - 1
        }
        
        //传递数据

        cell.groups = Array(groups![startIndex...endIndex])
        
    }
    
}
extension AmuseMenuView : UICollectionViewDelegate {
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageController.currentPage = Int(scrollView.contentOffset.x / scrollView.bounds.width)
    }

}



