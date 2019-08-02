//
//  BaseAnchorViewController.swift
//  DYZB
//
//  Created by caesar on 2019/8/1.
//  Copyright © 2019 caesar. All rights reserved.
//

import UIKit
private let itemMargin : CGFloat = 10
private let kItemW = (kScreenWidth - 3 * itemMargin) / 2
private let kItemH = kItemW * 3 / 4
private let kHeaderViewH : CGFloat = 50

 let kNormalCellID = "kNormalCollectionCellID"
 let kPrettyCellID = "kPrettyCollectionCellID"
 let kHeaderViewID = "kHeaderViewID"

class BaseAnchorViewController: UIViewController {

    // MARK:- 定义属性
    var baseModel : BaseViewModel!
    // MARK:- 懒加载属性
     lazy var collectionView : UICollectionView  = { [unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: itemMargin, bottom: 0, right: itemMargin)
        layout.headerReferenceSize = CGSize(width: kScreenWidth, height: kHeaderViewH)
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        //注册cell
        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        collectionView.register(UINib(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID)
        
        //注册头视图
        collectionView.register(UINib.init(nibName: "CollectionHaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        
        return collectionView
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        loadData()
    }
}

// MARK:- 设置UI界面
extension BaseAnchorViewController {
    
  @objc  func  setupUI(){
        
        view.backgroundColor = UIColor.white
        
        //添加collectionView到控制器view上
        view.addSubview(collectionView)
        
    }
}

// MARK:- 请求数据
//注意:如果扩展中的方法，子类要重写的话，父类必须加上@objc
extension BaseAnchorViewController {
  @objc  func loadData() {
    }
}

// MARK:- 遵守UICollectionViewDataSource协议
extension BaseAnchorViewController : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return baseModel.anchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return baseModel.anchorGroups[section].anchors.count
    }
    
  @objc  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionNormalCell
        
        cell.anchor = baseModel.anchorGroups[indexPath.section].anchors[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHaderView
        
        headerView.anchor = baseModel.anchorGroups[indexPath.section]
        return headerView
    }
    
}
