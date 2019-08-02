//
//  RecommendViewController.swift
//  DYZB
//
//  Created by caesar on 2019/7/29.
//  Copyright © 2019 caesar. All rights reserved.
//

import UIKit

// MARK:- 设置常量
private let kItemMargin : CGFloat = 10
private let kItmeW = (kScreenWidth - 3*kItemMargin) / 2
private let kItemNormalH = kItmeW * 3 / 4
private let kItemPrettyH = kItmeW * 4 / 3
private let kCyleviewH = kScreenWidth * 3 / 8
private let kGameViewH : CGFloat = 90


// MARK:- 创建RecommendViewController类
class RecommendViewController: BaseAnchorViewController {

   //懒加载属性
   private lazy var recommandVM :RecommendViewModel = RecommendViewModel()
   private lazy var cycleView : CollectionCycleView = {
        let cycleView = CollectionCycleView.creatCycleView()
        cycleView.frame = CGRect(x: 0, y: -(kCyleviewH + kGameViewH), width: kScreenWidth, height: kCyleviewH)
        return cycleView
    }()
   private lazy var gameView : RecommandGameView = {
     let gameView = RecommandGameView.creatRecommandGameView()
      gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenWidth, height: kGameViewH)
    
    return gameView
}()
    
}

// MARK:- 请求数据
extension RecommendViewController {
    override func loadData(){
        //0.给父类的viewModel赋值
        baseModel = recommandVM
        
        //1.请求推送的数据
        recommandVM.requestData(){
            //刷新数据
            self.collectionView.reloadData()
            
            //将数据传递到gameView中
            var groups = self.recommandVM.anchorGroups
            //移除推荐的数据
            groups.remove(at: 0)
            //移除颜值的数据
            groups.remove(at: 0)
            //添加更多数据
            let model = AnchorGroupModel()
            model.tag_name = "更多"
            model.icon_url = ""
            groups.append(model)
            self.gameView.groups = groups
        }
        //2.获取轮播图的数据
        recommandVM.requestCycleData {
            self.cycleView.cycleModels = self.recommandVM.cycleModels
        }
    }
}

// MARK:- 设置UI界面
extension RecommendViewController {
    
    override func setupUI(){
        //1.调用super.setupUI()
        super.setupUI()
        
        //2.将cycleView添加到collectionView上
        collectionView.addSubview(cycleView)
        
        //3.将gameView添加到collectionView上
        collectionView.addSubview(gameView)
        
        //4.设置collectionView的内边距
        collectionView.contentInset = UIEdgeInsets(top: kCyleviewH + kGameViewH, left: 0, bottom: 0, right: 0)
    }
    
}

// MARK:- 遵循UICollectionViewDelegateFlowLayout协议,对cell大小进行设置

extension RecommendViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        if indexPath.section == 1 {
            
            return CGSize(width: kItmeW, height: kItemPrettyH)
        }
        return CGSize(width: kItmeW, height: kItemNormalH)
    }
    
    //重写创建cell的方法
    override  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 1 {
            let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! CollectionPrettyCell
            cell.anchor = recommandVM.anchorGroups[indexPath.section].anchors[indexPath.item]
            
            return cell
        }else{
            return super.collectionView(collectionView, cellForItemAt: indexPath)
        }
    }
    
}

