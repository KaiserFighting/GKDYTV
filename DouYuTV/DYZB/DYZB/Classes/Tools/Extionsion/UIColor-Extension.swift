//
//  UIColor-Extension.swift
//  DYZB
//
//  Created by caesar on 2019/7/26.
//  Copyright © 2019 caesar. All rights reserved.
//

import UIKit


extension UIColor {
    
    convenience init( _ r : CGFloat, _ g : CGFloat , _ b : CGFloat){
        
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1.0)
    }
    //随机颜色
    class func getArc4randomColor () -> UIColor {
        return UIColor(CGFloat(arc4random_uniform(256)),CGFloat(arc4random_uniform(256)) , CGFloat(arc4random_uniform(256)))
    }

    
}
