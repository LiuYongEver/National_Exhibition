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

class BasicInformationViewController: UIViewController {

    var v:BasicView?
    var audioPlayer: STKAudioPlayer = STKAudioPlayer()
    var contry_code:String?
    
    
    init(title:String){
        super.init(nibName: nil, bundle: nil)
        self.contry_code = title
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setNaviView(){
        self.navigationController?.navigationBar.barTintColor = naviColor
        self.navigationController?.navigationBar.isTranslucent = false
       
        let backbutton = UIButton(type: .custom)
        backbutton.frame = CGRect(x: 0, y: 0, width:68, height: 60)
        //backbutton.setImage(UIImage(named: "back@1x"), for: .normal)
        let bti = UIImageView.init(frame:( CGRect(x:0, y: 13, width: 22, height: 22)))
        bti.image = #imageLiteral(resourceName: "back@1x")
        backbutton.addSubview(bti)
        backbutton.addTarget(self, action: #selector(touchReturn), for: .touchUpInside)
        let item = UIBarButtonItem(customView: backbutton)
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        barButtonItem.width = -5
        //item.tintColor = UIColor.white
        self.navigationItem.leftBarButtonItems = [barButtonItem,item]
        self.navigationItem.title = "国家信息详情"
        let dict:NSDictionary = [NSAttributedStringKey.foregroundColor: UIColor.white,NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 18)]
        //标题颜色
        self.navigationController?.navigationBar.titleTextAttributes = dict as? [NSAttributedStringKey : Any]
    }
    
    func setTabView(){
        var childVcs = [UIViewController]()
        
        childVcs.append(RecommendViewController())
        let title  =  ["基本信息","环境资源","政治军事","经济发展","社会状况","科技教育","国际关系","侨情","国际数据"]
        for i in 1...title.count-1{
            childVcs.append(UIViewController())
        }
        
        let vieww = IndexPageView(frame: FloatRect(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64),titles: title,child:childVcs,parentViewController: self)
        self.view.addSubview(vieww)
        
        //let nib = UINib(nibName: "BasicView", bundle: nil)
        v = BasicView.init(frame: self.view.frame, country_code: self.contry_code!)
        //nib.instantiate(withOwner: nil, options: nil)[0] as? BasicView
        v?.musicButton.addTarget(self, action: #selector(playMusic(_:)), for: .touchUpInside)
        //let vivi = UIView(frame:FloatRect(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64))
        childVcs[0].view.backgroundColor = backColor
        v?.backgroundColor = backColor
        childVcs[0].view = v
        
    }

    @objc func playMusic(_ btn:UIButton){
        btn.isSelected = !btn.isSelected
        if btn.isSelected{
           print("play")
          audioPlayer.play("http://www.abstractpath.com/files/audiosamples/sample.mp3")
        }else{
            print("stop")
           audioPlayer.stop()
        }
        
    }
    
    @objc func touchReturn(){
        
        self.dismiss(animated: false, completion: nil)
    }
    

    /*
    // MARK: - 网络请求
    */
    func Alarequest(){}
    
}

