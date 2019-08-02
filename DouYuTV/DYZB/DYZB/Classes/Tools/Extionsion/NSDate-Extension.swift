//
//  NSDate-Extension.swift
//  DYZB
//
//  Created by caesar on 2019/7/30.
//  Copyright © 2019 caesar. All rights reserved.
//

import UIKit

extension NSDate {
    //获取当前的时间秒数
    
  static func getCurrentTime() -> String {
        let nowDate = NSDate()
        let interval = Int(nowDate.timeIntervalSince1970)
        return "\(interval)"
    }
}
