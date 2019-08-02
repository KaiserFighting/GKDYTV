//
//  BaseViewModel.swift
//  DYZB
//
//  Created by caesar on 2019/8/1.
//  Copyright © 2019 caesar. All rights reserved.
//

import UIKit

class BaseViewModel{
 lazy var anchorGroups : [AnchorGroupModel] = [AnchorGroupModel]()
}

extension BaseViewModel {
    
    func loadAnchorsData(urlString : String , paramaters : [String : Any]? = nil ,finishedCallBack : @escaping () -> ()) {
        NetworkTools.requestData(type: .get, url: urlString,paramerters: paramaters) { (result) in
            guard let resultDic = result as? [String : Any]  else { return }
            guard let resultArray = resultDic["data"] as? [[String : Any]] else { return }
            
            for dict in resultArray {
                
                self.anchorGroups.append(AnchorGroupModel(dict: dict))
            }
            finishedCallBack()
        }
    }
}
