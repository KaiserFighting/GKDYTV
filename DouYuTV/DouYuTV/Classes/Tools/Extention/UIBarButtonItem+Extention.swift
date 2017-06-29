//
//  UIBarButtonItem+Extention.swift
//  DouYuTV
//
//  Created by caesar on 2017/6/29.
//  Copyright © 2017年 guokai. All rights reserved.
//

import UIKit

extension UIBarButtonItem{
    
    /*
     //创建一个类方法
     class func  createItem(imageName : String ,highImage : String = "" , size : CGSize = CGSize.zero) -> UIBarButtonItem {
     let btn = UIButton()
     
     btn.setImage(UIImage(named : imageName), for: .normal)
     btn.setImage(UIImage(named : highImage), for: .highlighted)
     if size == CGSize.zero {
     
     btn.sizeToFit()
     
     }else{
     
     btn.frame = CGRect(origin: CGPoint.zero, size: size)
     }
     return UIBarButtonItem(customView: btn)
     }
     */
   
    //便利构造函数 1> convenience开头,2>在构造函数中必须明确调用一个设计构造函数(必须使用self)
    //可以设置默认值。
    convenience init(imageName : String ,highImage : String = "" , size : CGSize = CGSize.zero){
        //1.创建UIButton
        let btn = UIButton()
        
        //2.设置btn的图片
        btn.setImage(UIImage(named : imageName), for: .normal)
        if highImage != "" {
            
            btn.setImage(UIImage(named : highImage), for: .highlighted)
        }
        //3.设置btn的尺寸
        if size == CGSize.zero {
            
            btn.sizeToFit()
        }else{
            btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }
      
        //4.创建UIBarButtonItem
        self.init(customView: btn)
    }
}
