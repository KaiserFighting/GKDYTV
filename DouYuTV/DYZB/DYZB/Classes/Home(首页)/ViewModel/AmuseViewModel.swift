//
//  AmuseViewModel.swift
//  DYZB
//
//  Created by caesar on 2019/8/1.
//  Copyright © 2019 caesar. All rights reserved.
//

import UIKit

class AmuseViewModel : BaseViewModel {

}
extension AmuseViewModel {
    //
    func loadAmuseData(finishedBack : @escaping () -> () ){
        
       loadAnchorsData(urlString: "http://capi.douyucdn.cn/api/v1/getHotRoom/2" , finishedCallBack: finishedBack)
    }
    
   
}
