//
//  BasicView.swift
//  National_Exbihition
//
//  Created by ly on 2017/11/9.
//  Copyright © 2017年 shikeTeam. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import StreamingKit
import Alamofire
import SVProgressHUD

protocol PushVCDelegate {
    func Push(vc:UIViewController);
    func present(vc:UIViewController);
     //func playMusic(str:String)
}



class BasicView: UIView{
    
    var pushDelegate:PushVCDelegate?
    var playAction: UIButton! = UIButton()
    var namelabel: UILabel! = UILabel()
    var topview: UIView! = UIView()
    var bottomview: UIView! = UIView()
    var videoView: UIImageView! = UIImageView()
    var mapButton = UIButton()
    var audioPlayer: STKAudioPlayer = STKAudioPlayer()
    
    var InfoLabels:[UILabel]? = [UILabel]()
    var musicButton = UIButton()
    var country_code:String!
    var videoCode:String?
    var CLLloaction:[Float]?
    var muUrl:String?
    var imaUrl:String?
    
    init(frame: CGRect,country_code:String) {
        super.init(frame: frame)
        self.country_code = country_code
        Alarequest()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func stream(_ aStream: Stream, handle eventCode: Stream.Event) {
        print(aStream.streamStatus.rawValue)
    }
    
    
    
    override func draw(_ rect: CGRect) {
       // self.backgroundColor = backColor
        audioPlayer.delegate = self
        SVProgressHUD.show(withStatus: "加载中")
        bottomview.frame = self.frame
        self.addSubview(bottomview)
        self.addSubview(videoView)
        self.addSubview(topview)
        self.addSubview(namelabel)
        self.addSubview(playAction)
        self.addSubview(mapButton)
        
        self.frame = FloatRect(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
        self.videoView.frame = FloatRect(0, 0, SCREEN_WIDTH, getHeight(450))
        //videoView.image = #imageLiteral(resourceName: "组 186")
        playAction.setImage(#imageLiteral(resourceName: "播放"), for: .normal)
        self.playAction.snp.makeConstraints({
            (make) in
               make.width.equalTo(getHeight(100))
               make.height.equalTo(getWidth(100))
               make.center.equalTo(self.videoView.center)
        })
        topview.snp.makeConstraints({
            (make) in
               make.width.equalTo(self.videoView.frame.width)
               make.height.equalTo(getHeight(90))
               make.topMargin.equalTo(0)
        })
        
        self.namelabel.snp.makeConstraints(
            { (make) in
                make.leftMargin.equalTo(getWidth(24))
                make.topMargin.equalTo(getHeight(23))
        })
        
        namelabel.textColor = UIColor.white
        
        
        for i in 1...7{
            let label = UILabel(frame:Rect(24, 450 + Double(64*i), 0, 0))
            label.font = UIFont.systemFont(ofSize: getHeight(32))
           // label.text = "国  名：中华人民共和国（China）"
            
            self.InfoLabels?.append(label)
        }
        
        for i in InfoLabels!{
            i.textColor = title2color
            i.sizeToFit()
            self.addSubview(i)
        }
        
        
     

       // mapButton.backgroundColor = naviColor
        mapButton.setImage(#imageLiteral(resourceName: "位置-线"), for: .normal)
        //mapButton.imageEdgeInsets = UIEdgeInsets.init(top: <#T##CGFloat#>, left: <#T##CGFloat#>, bottom: <#T##CGFloat#>, right: <#T##CGFloat#>)
        
        musicButton.setImage(#imageLiteral(resourceName: "音乐"), for: .normal)
        musicButton.setImage(#imageLiteral(resourceName: "stopPlay"), for: .selected)
        musicButton.addTarget(self, action: #selector(playMusic(_:)), for: .touchUpInside)
        mapButton.addTarget(self, action: #selector(ppush), for: .touchUpInside)
        //musicButton.backgroundColor = naviColor
 
    }
    

    @objc func ppush(){
        if CLLloaction != nil {
            print(CLLloaction)
         pushDelegate?.Push(vc: MapViewController.init(CLLocation:self.CLLloaction! ))
        }
    }
    
    @objc func playMusic(_ btn:UIButton){
        btn.isSelected = !btn.isSelected
        if btn.isSelected{
            print("play")
            if let mm = muUrl{
                print(mm.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
                SVProgressHUD.show(withStatus: "歌曲加载中")
                audioPlayer.play(mm.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!);
            }else{
                 SVProgressHUD.showInfo(withStatus: "暂无国歌")
                 SVProgressHUD.dismiss(withDelay: 1)
            }
        }else{
            print("stop")
            audioPlayer.stop()
        }
        
    }
   
    func Alarequest(){
        let url = rootUrl+"/find_nationinfo_pk"
        //print(country_code)
        let paramete = ["country_code":"\(country_code!)"]
        //print(paramete)
        Alamofire.request(url, method: .post,parameters:paramete).responseJSON(completionHandler: {
            response in
            if let al = response.response{
                // print(al)
                print(response.result.isSuccess)
            }else{
                SVProgressHUD.showError(withStatus: "网络连接失败")
                SVProgressHUD.dismiss(withDelay: 1)
            }
            
            if let js = response.result.value{
                let json = JSON(js)["data"]
                print(json)
                
                if json.count>0{
                    
                     DispatchQueue.main.async {
                        SVProgressHUD.dismiss()
                        self.namelabel.text = json["nation_z"].string!
                        self.InfoLabels![0].text = "国"+"\t\t\t\t"+"名: "+json["nation_z"].string!
                        self.InfoLabels![1].text = "所属大陆: "+json["continent_name"].string!
                       
                        if  json["establish_time"].string  != nil{
                            self.InfoLabels![2].text = "建立时间: "+json["establish_time"].string!;
                        }
                        if  json["capital"].string != nil{
                            self.InfoLabels![3].text = "首都(首府): "+json["capital"].string!;
                        }
                        if let jj = json["country_area"].string{
                            self.InfoLabels![4].text = "面"+"\t\t\t\t"+"积: " + jj
                        }
                        if let jj = json["country_emblem"].string{
                            self.InfoLabels![5].text = "行政区划: " + jj
                        }
                        if let jj = json["nation_song"].string{
                            self.InfoLabels![6].text = "国    歌: "
                            self.muUrl = imageUrl+jj
                        }
                        if let jj = json["video_code"].string{
                            self.videoCode = jj
                        }
                        if let jj = json["map_picture"].string{
                            self.imaUrl = jj
                            self.videoView.sd_setImage(with:getImage(fg: self.imaUrl!), placeholderImage: #imageLiteral(resourceName: "baccc"),completed: nil)
                        }
                        
                        
                        if let jj = json["capital_latitude"].float{
                           // print(jj)
                            self.CLLloaction = [Float]()
                            self.CLLloaction?.append(jj);
                            self.CLLloaction?.append((json["capital_longitude"].float!));
                         
                        }
                        print(self.CLLloaction)
                        
                        
                        for i in self.InfoLabels!{
                            i.sizeToFit()
                        }
                        
                       
                       self.musicButton.frame = FloatRect(self.InfoLabels![6].frame.width + 20, self.InfoLabels![6].frame.origin.y - 5, getWidth(41), getHeight(43))

                        self.mapButton.snp.makeConstraints({
                            make in
                            make.left.greaterThanOrEqualTo(self.InfoLabels![3].snp.right);
                            make.width.equalTo(getWidth(100))
                            make.height.equalTo(getHeight(50))
                            make.centerY.equalTo(self.InfoLabels![3])
                        })
                        
                        if self.muUrl != nil
                        {
                               self.addSubview(self.musicButton)
                        }
                        
                    
  
                        if self.videoCode == nil
                        {
                            //self.videoView.removeFromSuperview()
                            self.playAction.removeFromSuperview()
                        }
                        
                        
                        
                        
                        
                        
                     }
                    
                }else{
                    SVProgressHUD.showInfo(withStatus: "查询数据出错，请重试")
                    SVProgressHUD.dismiss(withDelay: 1)
                }
                
            }else{
                SVProgressHUD.showInfo(withStatus: "查询数据出错，请重试")
                SVProgressHUD.dismiss(withDelay: 1)
                
            }
        })
        
        
        
    }
}

extension BasicView:STKAudioPlayerDelegate{
    func audioPlayer(_ audioPlayer: STKAudioPlayer, stateChanged state: STKAudioPlayerState, previousState: STKAudioPlayerState) {
        print(state)
    }
    func audioPlayer(_ audioPlayer: STKAudioPlayer, logInfo line: String) {
        print(1)
    }
    func audioPlayer(_ audioPlayer: STKAudioPlayer, didStartPlayingQueueItemId queueItemId: NSObject) {
        print(2)
        SVProgressHUD.showSuccess(withStatus: "加载完成")
        SVProgressHUD.dismiss(withDelay: 0.2)
    }
    func audioPlayer(_ audioPlayer: STKAudioPlayer, didFinishPlayingQueueItemId queueItemId: NSObject, with stopReason: STKAudioPlayerStopReason, andProgress progress: Double, andDuration duration: Double) {
        print(3)
    }
    
    func audioPlayer(_ audioPlayer: STKAudioPlayer, didFinishBufferingSourceWithQueueItemId queueItemId: NSObject) {
        print(4)
    }
    func audioPlayer(_ audioPlayer: STKAudioPlayer, didCancelQueuedItems queuedItems: [Any]) {
        print(5)
    }
    
    func audioPlayer(_ audioPlayer: STKAudioPlayer, unexpectedError errorCode: STKAudioPlayerErrorCode) {
        
    }
}

