//
//  PageTitleView.swift
//  DYZB
//
//  Created by caesar on 2019/7/26.
//  Copyright © 2019 caesar. All rights reserved.
//

import UIKit

private let kScrollLineH : CGFloat = 2

protocol pageTitleViewDelegate : class {
    
    func pageTitleView(titleView : PageTitleView, selectedIndex : Int)
}

class PageTitleView : UIView {
 
    
    weak var delegate : pageTitleViewDelegate?
    
    fileprivate var currentIndex : Int = 0
    fileprivate var titles : [String]
    fileprivate lazy var titleLabels : [UILabel] = [UILabel]()
    fileprivate lazy var scrollView : UIScrollView = {
      let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
    }()
    fileprivate lazy var scrollLine : UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    
    // MARK:-  创建构造函数
     init(frame: CGRect, titles : [String]) {
        self.titles = titles
        
        super.init(frame: frame)
        //设置UI
       setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK:- 设置UI
extension PageTitleView {
    
    private func  setupUI(){
        //添加滚动视图
        addSubview(scrollView)
        scrollView.frame = bounds
        //设置labels
        setupTitleLabels()
        //设置底部分割线和底部滑块
        setupBottomLineAndScrollLine()
    }
    private func setupTitleLabels(){
        //常态的值，提高性能
        let labelW : CGFloat = frame.size.width / CGFloat(titles.count)
        let labelH : CGFloat = frame.size.height - kScrollLineH
        let labelY : CGFloat = 0
        
        for(index,title) in titles.enumerated(){
            
            let label = UILabel()
            label.text = title
            label.textColor = UIColor.gray
            label.font = UIFont.systemFont(ofSize: 17)
            label.tag = index
            label.textAlignment = .center
            
            let labelX : CGFloat = labelW * CGFloat(index)
            
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            scrollView.addSubview(label)
            titleLabels.append(label)
            
            //label添加点击事件
            label.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelClick(_:)))
            label.addGestureRecognizer(tap)
        }
    }
    private func setupBottomLineAndScrollLine(){
        
        //分割线
        let bottomline : UIView = UIView()
        bottomline.backgroundColor = UIColor.gray
        let bottomLineH : CGFloat = 0.5;
        bottomline.frame =  CGRect(x: 0, y: frame.size.height - bottomLineH, width: frame.size.width, height:bottomLineH)
        addSubview(bottomline)
        
        
        //获取第一个label
        //判定是否有值
        guard let firstLabel = titleLabels.first else { return }
        firstLabel.textColor = .orange
        
        //滑块
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.size.height - kScrollLineH, width: firstLabel.frame.size.width, height: kScrollLineH)
        scrollView.addSubview(scrollLine)
    }
}

// MARK:- Label的点击事件
extension PageTitleView {
    
    @objc private func titleLabelClick(_ tapGes:UITapGestureRecognizer){
        //1.获取点击的label
        guard let currentLabel = tapGes.view as? UILabel else { return }
        //2.获取之前的label
        let oldLabel = titleLabels[currentIndex]
        //3.设置字体颜色
        currentLabel.textColor = UIColor.orange
        oldLabel.textColor = UIColor.gray
        //4.设置滑块的x
        let scrollLineX = CGFloat(currentLabel.tag) * scrollLine.frame.size.width
        UIView.animate(withDuration: 0.2) {
            self.scrollLine.frame.origin.x =  scrollLineX
        }
        //5.保存当前的下标
        currentIndex = currentLabel.tag
        //6.通知代理
        delegate?.pageTitleView(titleView: self, selectedIndex: currentIndex)
    }
    
}
