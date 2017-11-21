//
//  BasicInformationViewController.swift
//  National_Exbihition
//
//  Created by ly on 2017/11/9.
//  Copyright © 2017年 shikeTeam. All rights reserved.
//

import UIKit
import StreamingKit
class BasicInformationViewController: UIViewController {

    var v:BasicView?
    var audioPlayer: STKAudioPlayer = STKAudioPlayer()

    
    
    init(title:String){
        super.init(nibName: nil, bundle: nil)
        self.title = title
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        backbutton.frame = CGRect(x: 200, y: 13, width: 18, height: 18)
        backbutton.setImage(UIImage(named: "back@1x"), for: .normal)
        backbutton.addTarget(self, action: #selector(touchReturn), for: .touchUpInside)
        let item = UIBarButtonItem(customView: backbutton)
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        barButtonItem.width = -5
        //item.tintColor = UIColor.white
        self.navigationItem.leftBarButtonItems = [barButtonItem,item]
        self.navigationItem.title = self.title
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
        
        let nib = UINib(nibName: "BasicView", bundle: nil)
        v = nib.instantiate(withOwner: nil, options: nil)[0] as? BasicView
        v?.musicButton.addTarget(self, action: #selector(playMusic(_:)), for: .touchUpInside)
        //let vivi = UIView(frame:FloatRect(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64))
        childVcs[0].view.addSubview(v!)
        
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
        
        self.dismiss(animated: true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
