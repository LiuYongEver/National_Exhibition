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
    let naviOffset:CGFloat = 64 // 导航栏偏移
    var titleButton = [UIButton]()
    let topback = UIScrollView()
     weak var delegate:resignDelegate?
    
    
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

        
        if titles.count<5{
            titleWidth =  (SCREEN_WIDTH/CGFloat(titles.count));
        }else{
            titleWidth = SCREEN_WIDTH/5
        }
        topback.frame = FloatRect(0, 0, SCREEN_WIDTH, interval)
        topback.contentSize = CGSize(width:titleWidth*CGFloat(titles.count),height:interval)
        topback.showsVerticalScrollIndicator = false
        topback.showsHorizontalScrollIndicator=false
        self.addSubview(topback)
        for i in 0...self.titles.count-1{
            
             let tyest = UIButton();
             tyest.setTitle(titles[i], for: .normal)
             tyest.setTitleColor(UIColor.white, for: .normal)
             tyest.frame = CGRect(x: CGFloat(i)*titleWidth,y:0,width: (titleWidth),height:interval)
            tyest.backgroundColor = backColor
            tyest.titleLabel?.font = UIFont.systemFont(ofSize: getHeight(32))
            tyest.setTitleColor(title2color, for: .normal)
            tyest.tag = i
            tyest.titleLabel?.adjustsFontSizeToFitWidth = true
            tyest.addTarget(self, action: #selector(changeto(btn:)), for: .touchUpInside)
            if i == 0{
                tyest.addSubview(line)
            }
            
            titleButton.append(tyest)
        }
        
        for i in titleButton{
            i.setTitleColor(naviColor, for: .selected)
            self.topback.addSubview(i)
        }
        
        titleButton[0].isSelected = true
        
        
        
        let lineBelow = UIView()
        lineBelow.frame = CGRect(x:0,y:interval-getHeight(1),width:SCREEN_WIDTH,height:getHeight(1))
        self.topback.addSubview(lineBelow)
        
        line.frame = CGRect(x:0,y:getHeight(-3),width:titleWidth,height:getHeight(4))
        line.backgroundColor = naviColor
        lineBelow.addSubview(line)
        
        scroll.showsVerticalScrollIndicator = false
        scroll.showsHorizontalScrollIndicator=false
        scroll.scrollsToTop = false
        
        scroll.backgroundColor = UIColor.gray
        scroll.frame = CGRect(x:0,y:interval,width:SCREEN_WIDTH,height:SCREEN_HEIGHT - interval)
        scroll.contentSize = CGSize(width:SCREEN_WIDTH*CGFloat(titles.count),height:SCREEN_HEIGHT - interval - naviOffset)
        scroll.isPagingEnabled = true
        scroll.delegate = self
        self.addSubview(scroll)
        
        for i in 0...self.titles.count-1{
            let vview  = UIView()
            vview.frame = CGRect(x: CGFloat(i)*(SCREEN_WIDTH),y:0,width: (SCREEN_WIDTH),height:SCREEN_HEIGHT - interval - naviOffset)
            vview.backgroundColor = UIColor.red
           self.parentViewController?.addChildViewController(childVcs![i]);
            childVcs![i].view.frame = CGRect(x:0,y:0,width:SCREEN_WIDTH,height:SCREEN_HEIGHT-interval-naviOffset)
            vview.addSubview(childVcs![i].view)
            self.scroll.addSubview(vview)
            
        }
        
        
        
    }
    
    
  @objc  func  changeto(btn:UIButton){
    
    for i in self.titleButton{
        if i != btn{
            i.isSelected = false
        }else{
            i.isSelected = true
        }
    }
    
        self.scroll.contentOffset.x = CGFloat(SCREEN_WIDTH*CGFloat(btn.tag))
    
//    if (btn.tag == 3 || btn.tag == 4) && self.topback.frame.origin.x == 0{
//        UIView.animate(withDuration: 0.3, animations: {
//            self.topback.frame.origin.x = -(SCREEN_WIDTH - self.titleWidth*2)
//        })
//
//    }else if ( btn.tag >= 4) && self.topback.frame.origin.x ==  -(SCREEN_WIDTH - self.titleWidth*2){
//
//    }else{
//        UIView.animate(withDuration: 0.3, animations: {
//            self.topback.frame.origin.x = 0
//        })
//    }
    
    
        //动画闭包
   UIView.animate(withDuration: 0.3, animations: {
        self.line.frame.origin.x = (self.titleWidth)*CGFloat(btn.tag)
        })
      
    }
    
    
    
   
}




extension IndexPageView:UIScrollViewDelegate{
   

    

    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        self.delegate?.resign()
          //self.parentViewController?.resignFirstResponder()
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentoffsetX = scrollView.contentOffset.x
        if (currentoffsetX).truncatingRemainder(dividingBy: SCREEN_WIDTH) == 0{
            
          
            
            
            let tag = currentoffsetX/SCREEN_WIDTH
            
            for i in self.titleButton{
                if CGFloat(i.tag) != tag{
                    i.isSelected = false
                }else{
                    i.isSelected = true
                }
            }
            
            switch Int(tag)  {
            case 4: self.topback.contentOffset.x = 0
            case 5: self.topback.contentOffset.x = SCREEN_WIDTH
            
            default:break
            }
            
            
            
            UIView.animate(withDuration: 0.1, animations: {
                self.line.frame.origin.x = (self.titleWidth)*CGFloat(tag)
            })
   
        }
        
        
        
    }
    
    
    
    
}

