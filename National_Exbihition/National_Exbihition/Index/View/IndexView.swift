//
//  IndexViewController.swift
//  National_Exbihition
//
//  Created by ly on 2017/11/8.
//  Copyright © 2017年 shikeTeam. All rights reserved.
//
import UIKit

class IndexPageView:UIView {
    
    var titles = [String]()
    let line = UIView()
    let scroll = UIScrollView()
    var titleWidth:CGFloat = 0
    let interval:CGFloat = 40//title高度
    private var childVcs : [UIViewController]?
    private weak var parentViewController : UIViewController?
    
    init(frame: CGRect,titles: [String],child:[UIViewController],parentViewController: UIViewController?) {
        self.titles = titles
        self.childVcs = child
        self.parentViewController = parentViewController
        super.init(frame: frame)
        self.setTitle()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTitle(){

        titleWidth =  (SCREEN_WIDTH/CGFloat(titles.count))
        for i in 0...self.titles.count-1{
            
             let tyest = UIButton();
             tyest.setTitle(titles[i], for: .normal)
             tyest.setTitleColor(UIColor.white, for: .normal)
             tyest.frame = CGRect(x: CGFloat(i)*titleWidth,y:0,width: (titleWidth),height:interval)
            tyest.backgroundColor = UIColor.brown
            tyest.tag = i
            tyest.addTarget(self, action: #selector(changeto(btn:)), for: .touchUpInside)
            self.addSubview(tyest)
            if i == 0{
                tyest.addSubview(line)
                
            }
            
        }
        
        let lineBelow = UIView()
        lineBelow.frame = CGRect(x:0,y:interval-3,width:SCREEN_WIDTH,height:3)
        self.addSubview(lineBelow)
        
        line.frame = CGRect(x:0,y:0,width:(SCREEN_WIDTH/CGFloat(titles.count)),height:3)
        line.backgroundColor = UIColor.blue
        lineBelow.addSubview(line)
        
        scroll.showsVerticalScrollIndicator = false
        scroll.showsHorizontalScrollIndicator=false
        scroll.scrollsToTop = false
        
        scroll.backgroundColor = UIColor.gray
        scroll.frame = CGRect(x:0,y:interval,width:SCREEN_WIDTH,height:SCREEN_HEIGHT - interval)
        scroll.contentSize = CGSize(width:SCREEN_WIDTH*CGFloat(titles.count),height:SCREEN_HEIGHT - interval)
        scroll.isPagingEnabled = true
        scroll.delegate = self
        self.addSubview(scroll)
        
        for i in 0...self.titles.count-1{
            let vview  = UIView()
            vview.frame = CGRect(x: CGFloat(i)*(SCREEN_WIDTH),y:0,width: (SCREEN_WIDTH),height:SCREEN_HEIGHT - interval)
            vview.backgroundColor = UIColor.red
            self.parentViewController?.addChildViewController(childVcs![i])
            childVcs![i].view.frame = CGRect(x:0,y:0,width:SCREEN_WIDTH,height:SCREEN_HEIGHT-interval)
            vview.addSubview(childVcs![i].view)
            self.scroll.addSubview(vview)
            
        }
        
        
        
    }
    
    
  @objc  func  changeto(btn:UIButton){
        
        self.scroll.contentOffset.x = CGFloat(SCREEN_WIDTH*CGFloat(btn.tag))
        //动画闭包
       UIView.animate(withDuration: 0.3, animations: {
        self.line.frame.origin.x = (self.titleWidth)*CGFloat(btn.tag)
        })
    
      
    }
    
    
    
   
}




extension IndexPageView:UIScrollViewDelegate{
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {

        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentoffsetX = scrollView.contentOffset.x
        if (currentoffsetX).truncatingRemainder(dividingBy: SCREEN_WIDTH) == 0{
            let tag = currentoffsetX/SCREEN_WIDTH
            UIView.animate(withDuration: 0.3, animations: {
                self.line.frame.origin.x = (self.titleWidth)*CGFloat(tag)
            })
   
        }
        
        
        
    }
    
    
    
    
}

