//
//  HomeViewController.swift
//  DYZB
//
//  Created by caesar on 2019/7/26.
//  Copyright © 2019 caesar. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    //懒加载title
    private lazy var titleView : PageTitleView = { [weak self] in
        let titleFrame = CGRect(x: 0, y: KNavgationHeight, width: kScreenWidth, height: kTitleH)
        let titles : [String] = ["推荐","直播","关注","趣玩"]
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
        titleView.delegate = self
        
       return titleView
    }()
    //懒加载内容
    private lazy var pageContentView : PageContentView = { [weak self] in
        
        let contentFrame = CGRect(x: 0, y: KNavgationHeight + kTitleH, width: kScreenWidth, height: kScreenHeight - KNavgationHeight - kTitleH - KTabBarHeight)
        
        var childs  = [UIViewController]()
        childs.append(RecommendViewController())
        childs.append(GameViewController())
        childs.append(AmuseViewController())
        for _ in 0..<1{
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(CGFloat(arc4random_uniform(255)), CGFloat(arc4random_uniform(255)), CGFloat(arc4random_uniform(255)))
            childs.append(vc)
        }
         let pageContentView = PageContentView(frame: contentFrame, childVcs: childs, parentVc: self)
        pageContentView.delegate = self
        
        return pageContentView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置UI
        setupUI()
    }
}

// MARK:- 设置UI界面
extension HomeViewController{
    
    private func setupUI(){
//        //不需要调整UIScrollView的内边距
//        automaticallyAdjustsScrollViewInsets = false
        
        //设置导航条
        setupNavigationItem()
        //添加titleView
        view.addSubview(titleView)
        
        //添加contentView
        view.addSubview(pageContentView)
    }
    
    private func setupNavigationItem() {
        
        navigationItem.leftBarButtonItem = UIBarButtonItem("logo")
        
        let size = CGSize(width: 40, height: 40)
        //使用构造函数
        let historyItem = UIBarButtonItem("image_my_history", "Image_my_history_click", size)
        let searchItem = UIBarButtonItem("btn_search", "btn_search_clicked", size)
        let qrcodeItem = UIBarButtonItem("Image_scan", "Image_scan_click", size)
        
        navigationItem.rightBarButtonItems = [historyItem , searchItem, qrcodeItem]
    }
    
}

// MARK:- 准守PageTitleViewDelgate协议
extension HomeViewController : pageTitleViewDelegate{
    
    func pageTitleView(titleView: PageTitleView, selectedIndex: Int) {
        //设置contentView的对应的视图
        pageContentView.setCurrendIndex(currendIndex: selectedIndex)
    }
    
}

// MARK:- 遵守PageContentViewDelegate协议
extension HomeViewController : PageContentViewDelegate{
    
    func pageContentView(_ pageView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        titleView.setTitleWithProgress(progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
    
}

