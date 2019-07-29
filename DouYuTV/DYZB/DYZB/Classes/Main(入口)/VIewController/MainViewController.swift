//
//  MainViewController.swift
//  DYZB
//
//  Created by caesar on 2019/7/26.
//  Copyright © 2019 caesar. All rights reserved.
//

import UIKit
//Storyboard References支持9.0以及9.0+
class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChildVc("Home")
        addChildVc("Live")
        addChildVc("Follow")
        addChildVc("Profile")
    }
    
    //添加
    private func addChildVc(_ stroyBoard : String){
        
        let Vc = UIStoryboard(name: stroyBoard, bundle: nil).instantiateInitialViewController()!
        addChild(Vc)
    }
    

}
