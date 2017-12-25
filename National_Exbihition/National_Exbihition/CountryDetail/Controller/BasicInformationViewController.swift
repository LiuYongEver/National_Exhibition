//
//  BasicInformationViewController.swift
//  National_Exbihition
//
//  Created by ly on 2017/11/9.
//  Copyright © 2017年 shikeTeam. All rights reserved.
//

import UIKit
import StreamingKit
import Alamofire
import SVProgressHUD
import SDWebImage

class BasicInformationViewController: UIViewController{

    var v:BasicView?
    var contry_code:String?
    var defaultCode:Int!


    
    lazy var PoloticV:UIView = {
        let vie = PoliticView.init(frame: self.view.frame, country_code: self.contry_code!)
        vie.backgroundColor = backColor
        vie.psdelegate = self
        return vie
    }()
    
    lazy var EconomicV:UIView = {
        let vie = EconomicView.init(frame: self.view.frame, country_code: contry_code!)
        vie.backgroundColor = backColor
        vie.psdelegate = self
        return vie
    }()
    
    lazy var SocietyV:UIView = {
        let vie = SocietyView.init(frame: self.view.frame, country_code: contry_code!)
        vie.backgroundColor = backColor
        vie.psdelegate = self
        return vie
    }()
    
    lazy var TechnologyV:UIView = {
        let vie = TechnologyView.init(frame: self.view.frame, country_code: contry_code!)
        vie.backgroundColor = backColor
        vie.psdelegate = self
        return vie
    }()
    
    lazy var RelatonshipV:UIView = {
        let vie = RelationshipView.init(frame: self.view.frame, country_code: contry_code!)
        vie.backgroundColor = backColor
        vie.psdelegate = self
        return vie
    }()
    
    lazy var OverSeaV:UIView = {
        let vie = OverseasView.init(frame: self.view.frame, country_code: contry_code!)
        vie.backgroundColor = backColor
        vie.psdelegate = self
        return vie
    }()
    
    
    
    
    init(title:String,defaultCode:Int){
        super.init(nibName: nil, bundle: nil)
        self.contry_code = title
        self.defaultCode = defaultCode
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = backColor
        setNaviView()
        setTabView()

        //vivi.addSubview(v!)
        
        // Do any additional setup after loading the view.
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.v?.audioPlayer.stop()
        SVProgressHUD.dismiss()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setNaviView(){
        self.navigationItem.title = "国家信息详情"
        
    }
    
    func setTabView(){
        var childVcs = [UIViewController]()
        
        childVcs.append(RecommendViewController())
        let title  =  ["基本信息","环境资源","政治军事","经济发展","社会状况","科技教育","国际关系","侨情"]
        for i in 1...title.count-1{
            childVcs.append(UIViewController())
        }
        
       
        let vieww = IndexPageView(frame: FloatRect(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64),titles: title,child:childVcs,parentViewController: self)
        
        vieww.changeto(btn: vieww.titleButton[defaultCode])
        vieww.changeTopback(btn:vieww.titleButton[defaultCode] )
        self.view.addSubview(vieww)
        
        //let nib = UINib(nibName: "BasicView", bundle: nil)
        v = BasicView.init(frame: self.view.frame, country_code: self.contry_code!)
        v?.pushDelegate = self
        //nib.instantiate(withOwner: nil, options: nil)[0] as? BasicView
       // v?.musicButton.addTarget(self, action: #selector(playMusic(_:)), for: .touchUpInside)
        //let vivi = UIView(frame:FloatRect(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64))
        childVcs[0].view.backgroundColor = backColor
        v?.backgroundColor = backColor
        childVcs[0].view = v
        let ev = Environment.init(frame: self.view.frame, country_code: self.contry_code!)
        ev.psdelegate = self
        childVcs[1].view = ev
        childVcs[2].view = PoloticV
        childVcs[3].view = EconomicV
        childVcs[4].view = SocietyV
        childVcs[5].view = TechnologyV
         childVcs[6].view = RelatonshipV
        childVcs[7].view = OverSeaV
    }


    @objc func touchReturn(){
        
        self.dismiss(animated: false, completion: nil)
    }
    

    
    

    /*
    // MARK: - 网络请求
    */
    func Alarequest(){}
    
}
extension BasicInformationViewController:PushVCDelegate{
    func Push(vc: UIViewController) {
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
        vc.hidesBottomBarWhenPushed = false
    }
    func present(vc: UIViewController) {
        self.present(vc, animated: true, completion: nil)
    }
    
    
}
