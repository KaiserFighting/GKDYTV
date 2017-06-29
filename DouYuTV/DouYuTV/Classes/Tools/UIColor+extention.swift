//
//  UIColor+extention.swift
//  GK_Page
//
//  Created by caesar on 2017/5/24.
//  Copyright © 2017年 guokai. All rights reserved.
//

import UIKit

extension UIColor{
    
    class func random() ->UIColor{
        //在swfit中整数不能和浮点型相除
        return UIColor(red: CGFloat(arc4random_uniform(255)) / 255.0, green: CGFloat(arc4random_uniform(255)) / 255.0, blue: CGFloat(arc4random_uniform(255)) / 255.0, alpha: 1.0)
    }
    
   /*swift的默认参数
     特性 ： 在extension扩展函数，必须扩充遍历构造器函数
     1>必须在init前面加上convenience
     2>必须调用self.init()原有的某一个构造函数
    */
    
    convenience init(r : CGFloat , g : CGFloat , b : CGFloat , a : CGFloat = 1.0) {//alpha 默认为1.0
        self.init(red : r / 255, green : g / 255, blue : b / 255, alpha : a)
    }
    
    //十六进制的转换
    convenience init?(hexSting : String){
        
      //## # 0x 
        //1.判断字符串的长度是否大于等于6
        guard hexSting.characters.count > 6 else {
            return nil
        }
        //2.将字符串转换成大写
        var hexTempString = hexSting.uppercased()
        //3.判断字符前缀是否是0X 或者##
        if  hexTempString.hasPrefix("OX") || hexTempString.hasPrefix("##"){
            //使用as将swift的字符串转化后OC的字符串
            hexTempString = (hexSting as NSString).substring(from: 2)
        }
        //4.判断字符串的前缀是否是#
        if hexTempString.hasPrefix("#") {
            hexTempString = (hexSting as NSString).substring(from: 1)
        }
        //5.获取RGB对应的十六进制
        var range = NSRange(location : 0 , length : 2)
        let rHex = (hexTempString as NSString).substring(with: range)
        range.location = 2
        let gHex = (hexTempString as NSString).substring(with: range)
        range.location = 4
        let bHex = (hexTempString as NSString).substring(with: range)
        
        //6.将十六机制转化成数字
        var r : UInt32 = 0
        var g : UInt32 = 0
        var b : UInt32 = 0
        //使用扫描器
        Scanner(string: rHex).scanHexInt32(&r)
        Scanner(string: gHex).scanHexInt32(&g)
        Scanner(string: bHex).scanHexInt32(&b)
        self.init(r: CGFloat(r), g: CGFloat(g), b: CGFloat(b))
    }
}

//MARK -- 只从颜色获取RGB值
extension UIColor{
    func getRGBValue() ->(CGFloat , CGFloat ,CGFloat){
        //获取RGB值
        var red   : CGFloat = 0
        var green : CGFloat = 0
        var blue  : CGFloat = 0
        
        getRed(&red, green: &green, blue: &blue, alpha: nil)
         return (red * 255 ,green * 255 , blue * 255)
    }
}









