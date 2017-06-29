//
//  MainViewController.swift
//  DouYuTV
//
//  Created by caesar on 2017/6/28.
//  Copyright © 2017年 guokai. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        addChildVcName("Home")
        addChildVcName("Live")
        addChildVcName("Follow")
        addChildVcName("Profile")
        
    }

    private func addChildVcName(_ storyName : String){
        //1.通过stroyBoard获取控制器
        let childVc = UIStoryboard.init(name: storyName, bundle: nil).instantiateInitialViewController()!
        //2.将childVc作为子控制器
        addChildViewController(childVc)
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
