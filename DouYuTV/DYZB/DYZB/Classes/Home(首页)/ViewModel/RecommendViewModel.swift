//
//  RecommendViewModel.swift
//  DYZB
//
//  Created by caesar on 2019/7/30.
//  Copyright © 2019 caesar. All rights reserved.
//

import UIKit
//viewModel:是一个放置用户输入验证逻辑，视图显示逻辑，发起网络请求和其他各种样式代码发地方
class RecommendViewModel  : BaseViewModel {

    // MARK:- 懒加载属性
    lazy var cycleModels : [CycleModel] = [CycleModel]()
    var bigGroupModel : AnchorGroupModel = AnchorGroupModel()
    var prettyGroupModel : AnchorGroupModel = AnchorGroupModel()
    
}

// MARK:- 发起网络请求
extension RecommendViewModel {
    //请求推荐数据
    func requestData(_ finishBack : @escaping () -> () ) {
    //0.定义参数
    let parameters = ["limit" : "4", "offset" : "0", "time" : NSDate.getCurrentTime()]
    //1.创建一个队列
      let disGroup = DispatchGroup()
        
    //2.请求第一部分的推荐数据
        //加入到队列中
        disGroup.enter()
        //http://capi.douyucdn.cn/api/v1/getbigDataRoom?time=1474252024
        NetworkTools.requestData(type: .get, url: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", paramerters: ["time" : NSDate.getCurrentTime()]) { (result) in
            
            //1.将结果转成字典类型
            guard let resultDict = result as? [String : Any] else { return }
            //2.根据data该key，获取数组 (数组中保存的是字典对象)
            guard let resultArray = resultDict["data"] as? [[String : Any]] else { return }
            //3.遍历数字，获取字典，将字典转化成模型对象
            //3.1设置组的属性
            self.bigGroupModel.tag_name = "热门"
            self.bigGroupModel.icon_name = "home_header_hot"
            //3.2遍历获取主播信息
            for dict in resultArray{
                let anchor = AnchorModel(dict: dict)
                self.bigGroupModel.anchors.append(anchor)
            }
           //离开
            disGroup.leave()
        }
    
    //3.请求中间的颜值数据
        // http://capi.douyucdn.cn/api/v1/getVerticalRoom?limit=4&offset=0&time=1474252024
        disGroup.enter()
        NetworkTools.requestData(type: .get, url: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", paramerters: parameters) { (result) in
            //1.将结果转成字典类型
            guard let resultDict = result as? [String : Any] else { return }
            //2.根据data该key，获取数组 (数组中保存的是字典对象)
            guard let resultArray = resultDict["data"] as? [[String : Any]] else { return }
            //3.遍历数字，获取字典，将字典转化成模型对象
             //3.1设置组的属性
              self.prettyGroupModel.tag_name = "颜值"
              self.prettyGroupModel.icon_name = "home_header_phone"
            
              //3.2遍历获取主播信息
            for dict in resultArray{
//                print(dict["nickname"])
                 let anchor = AnchorModel(dict: dict)
//                 print(anchor.nickname)
                 self.prettyGroupModel.anchors.append(anchor)
            }
            
           //离开
            disGroup.leave()
        }
    //4.请求后面的游戏数据
        // http://capi.douyucdn.cn/api/v1/getHotCate?limit=4&offset=0&time=1564455649
        disGroup.enter()
        let urlString = "http://capi.douyucdn.cn/api/v1/getHotCate"
        loadAnchorsData(urlString: urlString , paramaters: parameters) {
            disGroup.leave()
        }
        
        // 5.所有的数据都请求到,之后进行排序
        disGroup.notify(queue: DispatchQueue.main){
            self.anchorGroups.insert(self.prettyGroupModel, at: 0)
            self.anchorGroups.insert(self.bigGroupModel, at: 0)
            
            finishBack()
        }
        
    }
    
    //请求无线轮播数据
    //http://www.douyutv.com/api/v1/slide/6?version=2.300
    func requestCycleData(_ finishBack : @escaping () -> ()) {
        NetworkTools.requestData(type: .get, url: "http://www.douyutv.com/api/v1/slide/6", paramerters: ["version" : "2.300"]) { (result) in
            //获取整体字典数据
            guard let resultDic = result as? [String : Any] else { return }
            //获取data的key数组数据
            guard let resultArray = resultDic["data"] as? [[String : Any]] else { return }
            //将数据转化成模型对象
            for dict in resultArray{
                 self.cycleModels.append(CycleModel(dict: dict))
            }
            finishBack()
        }
    }
}





















