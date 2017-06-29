//
//  HomeViewController.swift
//  DouYuTV
//
//  Created by caesar on 2017/6/29.
//  Copyright © 2017年 guokai. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //1.设置UI界面
        setupUI()
        
    }

}
//MARK:--设置UI界面
extension HomeViewController {
    
    fileprivate func setupUI(){
        view.backgroundColor = UIColor.random()
        
        //1.设置导航栏
        setupNavitionBar()

    }
    
    fileprivate func setupNavitionBar(){
        
        //1.设置左按钮
//        navigationItem.leftBarButtonItem = UIBarButtonItem.createItem(imageName: "logo")
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        
        //2.设置右按钮
        let  size = CGSize(width: 40, height: 40)
        let historyBtn = UIBarButtonItem(imageName: "image_my_history", highImage: "Image_my_history_click", size: size)
        let searchBtn = UIBarButtonItem(imageName: "btn_search", highImage: "btn_search_clicked", size: size)
        let qrcodeItem = UIBarButtonItem(imageName: "Image_scan", highImage: "Image_scan_click", size: size)
        //按钮创建布局由右往左
        navigationItem.rightBarButtonItems = [historyBtn,searchBtn,qrcodeItem]
    }
    
}
