//
//  GameViewController.swift
//  DYZB
//
//  Created by caesar on 2019/7/31.
//  Copyright © 2019 caesar. All rights reserved.
//

import UIKit

private let kEdgeMargin : CGFloat = 10
private let kItemW = (kScreenWidth - 2 * kEdgeMargin) / 3
private let kItemH = kItemW * 6 / 5
private let kHeaderViewH : CGFloat = 50
private let kGameViewH : CGFloat = 90

private let gameVCViewCellID = "gameVCViewCellID"
private let kgameHeaderViewID = "kHeaderViewID"

class GameViewController: UIViewController {
    // MARK:- 定义属性
    fileprivate lazy var  gameVM : GameViewModel = GameViewModel()
    fileprivate lazy var  games : [GameModel] = [GameModel]()
    fileprivate lazy var  collectionView : UICollectionView = { [unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: kEdgeMargin, bottom: 0, right: kEdgeMargin)
        layout.headerReferenceSize = CGSize(width: kScreenWidth, height: kHeaderViewH)
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.register(UINib.init(nibName: "CollectionGameViewCell", bundle: nil), forCellWithReuseIdentifier: gameVCViewCellID)
        collectionView.dataSource = self
        collectionView.autoresizingMask = [.flexibleHeight ,.flexibleWidth]
        
        //注册headerView
        collectionView.register(UINib(nibName: "CollectionHaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: kgameHeaderViewID)
        return collectionView

    }()
    fileprivate lazy var  topHeaderView : CollectionHaderView = {
        let headerView  = CollectionHaderView.crertCollectionViewClassMethod()
        headerView.frame = CGRect(x: 0, y:-(kHeaderViewH + kGameViewH), width: kScreenWidth, height: kHeaderViewH)
        headerView.titleNameLabel.text = "常见"
        headerView.iconImageView.image = UIImage(named: "Img_orange")
        headerView.moreBtn.isHidden = true
        
        return headerView
    }()
    fileprivate lazy var  gameView : RecommandGameView = {
       let gameView = RecommandGameView.creatRecommandGameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenWidth, height: kGameViewH)
        return gameView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.purple
        
        setupUI()
        loadData()
    }
}

// MARK:- 设置UI界面
extension GameViewController {
    
    fileprivate func setupUI() {
        
        //添加collectionView到gameVC
        view.addSubview(collectionView)
        
        //添加headerView到collectionView上
        collectionView.addSubview(topHeaderView)
        
        //添加gameView到collectionView上面
        collectionView.addSubview(gameView)
        
        //设置collectionView的内边距
        collectionView.contentInset = UIEdgeInsets(top: kHeaderViewH + kGameViewH, left: 0, bottom: 0, right: 0)
    }
}
// MARK:- 获取游戏的数据
extension GameViewController {
    
    fileprivate func loadData (){
        gameVM.getGameAllData {
            //1.获取全部数据
            let tempArray = self.gameVM.games[0..<60]//数组的截取
            self.games = Array(tempArray)//转化成数组
            self.collectionView.reloadData()
            
            //2.获取常见的数据
            self.gameView.groups = Array(tempArray[0..<10])
        }
    }
}


// MARK:- 遵守UICollectionViewDataSource协议
extension GameViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return games.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: gameVCViewCellID, for: indexPath) as! CollectionGameViewCell
        cell.group = games[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kgameHeaderViewID, for: indexPath) as! CollectionHaderView
        
        headerView.titleNameLabel.text = "全部"
        headerView.iconImageView.image = UIImage(named: "Img_orange")
        headerView.moreBtn.isHidden = true
        
        return headerView
    }
    

}

