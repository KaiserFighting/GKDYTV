//
//  UIBarButtonItem-Extension.swift
//  DYZB
//
//  Created by caesar on 2019/7/26.
//  Copyright © 2019 caesar. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
//    //创建类方法
//    class func creatItem(_ normalImageName : String ,_ highImageName : String , _ size : CGSize) -> UIBarButtonItem{
//        
//        let btn = UIButton()
//        btn.setImage(UIImage(named: normalImageName), for: .normal)
//        btn.setImage(UIImage(named: highImageName), for: .highlighted)
//        btn.frame = CGRect(origin: CGPoint.zero, size: size)
//        
//        return UIBarButtonItem(customView: btn)
//    }
    
    //最好使用构造函数
    //便利构造函数的条件
    //1>convenience开头
    //2>在构造函数中必须明确调用一个设计的构造函数(self)
    convenience  init(_ normalImageName : String ,_ highImageName : String  = "" , _ size : CGSize = CGSize.zero) {//使用默认参数
        let btn = UIButton()
        btn.setImage(UIImage(named: normalImageName), for: .normal)
        if highImageName != ""{
            btn.setImage(UIImage(named: highImageName), for: .highlighted)
        }
        if size == CGSize.zero {
            btn.sizeToFit()
        }else{
            btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }
        //创建UIBarButtonItem
        self.init(customView : btn)
    }
    
}

