//
//  CommunityView.swift
//  National_Exbihition
//
//  Created by 刘勇 on 2018/4/20.
//  Copyright © 2018年 shikeTeam. All rights reserved.
//

import UIKit

class CommunityViewController: UIViewController {
    
    
    
    let ImageExbihition = UIImageView()
    
    lazy var askButton:UIButton = {
        let button = UIButton.init(frame: Rect(600,903, 117, 117))
        button.setImage(#imageLiteral(resourceName: "Write"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsetsMake(20, 20, 20, 20)
        button.layer.cornerRadius = getHeight(117/2)
        button.backgroundColor = naviColor
        button.layer.masksToBounds = true
        button.layer.shadowOpacity = 0.8
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize.init(width: 1, height: 1)
        
        button.addTarget(self, action: #selector(askQuestion), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidAppear(_ animated: Bool) {
        //UIApplication.shared.statusBarStyle = .lightContent
        //  setNaviView()
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNaviView()
        self.view.backgroundColor = backColor
        // self.navigationController?.navigationBar.isHidden = true
        setPageView()
        self.view.addSubview(askButton)
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @objc func askQuestion(){
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.pushViewController(AskViewController(), animated: true)
        self.tabBarController?.tabBar.isHidden = false
        
    }
    
    
    
    func setNaviView(){
        self.navigationController?.navigationBar.barTintColor = naviColor
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationItem.title = "问答社区"
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"",style:.plain,target:nil,action:nil);
        
    }
    
    func  setPageView(){
        var childVcs = [UIViewController]()
       // childVcs.append(RecommendViewController())
        let title  =  ["推荐","基本信息","环境资源","政治军事","经济发展","社会状况","科技教育","国际关系","侨情"]
        for i in 0...title.count-1{
            childVcs.append(CommunityTableViewController(index:title[i]))
        }
        
        let vieww = IndexPageView(frame: FloatRect(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64),titles: title,child:childVcs,parentViewController: self)
        self.view.addSubview(vieww)
    }
    
    
    
    
}
