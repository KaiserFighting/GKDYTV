//
//  GameViewModel.swift
//  DYZB
//
//  Created by caesar on 2019/8/1.
//  Copyright © 2019 caesar. All rights reserved.
//

import UIKit

class GameViewModel{
    
    lazy var games : [GameModel] = [GameModel]()
}

// MARK:- 获取数据
extension GameViewModel {
    
    func  getGameAllData(finishedBack : @escaping () -> ()){
        //http://capi.douyucdn.cn/api/v1/getColumnDetail?shortName=games
        NetworkTools.requestData(type: .get, url: "http://capi.douyucdn.cn/api/v1/getColumnDetail") { (result) in
            //1.获取字典对象
            guard let resultDic = result as? [String : Any] else { return }
            //2.通过data的key获取数组
            guard let resultArray = resultDic["data"] as? [[String : Any]] else { return }
            //3.数组转化成模型
            for dict in resultArray {//闭包中必须使用self
                self.games.append(GameModel(dict : dict))
            }
            
            //4.数据回调
            finishedBack()
        }
    }
}

