
//
//  Comment.swift
//  DYZB
//
//  Created by caesar on 2019/7/26.
//  Copyright © 2019 caesar. All rights reserved.
//

import UIKit


let kScreenWidth  = UIScreen.main.bounds.width
let kScreenHeight = UIScreen.main.bounds.height

let kIphoneX = UIApplication.shared.statusBarFrame.size.height > 20 ? true : false
let kTitleH : CGFloat = 60
//let kStatueBarH : CGFloat = 20
//let kNavigationBarH : CGFloat = kIphoneX ? 68 : 44

let KNavgationHeight = kIphoneX ? CGFloat(88.0) : CGFloat(64.0)
let KTabBarHeight = kIphoneX ? CGFloat(83.0) : CGFloat(49.0)
let kBottomBarHeight = kIphoneX ? CGFloat(34.0) : CGFloat(0)

let KHeightTime = kScreenHeight / 667
