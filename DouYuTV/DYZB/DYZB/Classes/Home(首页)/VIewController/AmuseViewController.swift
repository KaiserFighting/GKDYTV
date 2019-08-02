//
//  AmuseViewController.swift
//  DYZB
//
//  Created by caesar on 2019/8/1.
//  Copyright © 2019 caesar. All rights reserved.
//

import UIKit

private let kMenuViewH : CGFloat = 200

class AmuseViewController: BaseAnchorViewController {

    fileprivate lazy var amuseVM : AmuseViewModel = AmuseViewModel()
    fileprivate lazy var menuView : AmuseMenuView = {
       let menuView = AmuseMenuView.creatMenuView()
        menuView.frame = CGRect(x: 0, y: -kMenuViewH, width: kScreenWidth, height: kMenuViewH)
        return menuView
    }()
}

// MARK:- 设置UI界面
extension AmuseViewController {
    
    override func setupUI() {
        super.setupUI()
        //加载menuView
        collectionView.addSubview(menuView)
        collectionView.contentInset = UIEdgeInsets(top: kMenuViewH, left: 0, bottom: 0, right: 0)
    }
}

// MARK:- 请求数据
extension AmuseViewController {
    
    override func loadData() {
        
        //给父视图中的ViewModel赋值
        baseModel = amuseVM
        amuseVM.loadAmuseData {
            
            self.collectionView.reloadData()
            
            var tempArray = self.amuseVM.anchorGroups
            tempArray.removeFirst()
            self.menuView.groups = tempArray
        }
    }
}
