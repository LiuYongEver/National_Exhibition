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
     func Push(vc:UIViewController)
}



class BasicView: UIView {
    
    var pushDelegate:PushVCDelegate?
    var playAction: UIButton! = UIButton()
    var namelabel: UILabel! = UILabel()
    var topview: UIView! = UIView()
    var videoView: UIImageView! = UIImageView()
    var mapButton = UIButton()
    
    
    var InfoLabels:[UILabel]? = [UILabel]()
    var musicButton = UIButton()
    var country_code:String!
    var CLLloaction:[Float]?
    
    init(frame: CGRect,country_code:String) {
        super.init(frame: frame)
        self.country_code = country_code
        Alarequest()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func draw(_ rect: CGRect) {
       // self.backgroundColor = backColor
        SVProgressHUD.show(withStatus: "加载中")
        self.addSubview(videoView)
        self.addSubview(topview)
        self.addSubview(namelabel)
        self.addSubview(playAction)
        self.addSubview(mapButton)
        
        self.frame = FloatRect(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
        self.videoView.frame = FloatRect(0, 0, SCREEN_WIDTH, getHeight(450))
        videoView.image = #imageLiteral(resourceName: "组 186")
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
        
        
        self.addSubview(self.musicButton)

       // mapButton.backgroundColor = naviColor
        mapButton.setImage(#imageLiteral(resourceName: "位置-线"), for: .normal)
        //mapButton.imageEdgeInsets = UIEdgeInsets.init(top: <#T##CGFloat#>, left: <#T##CGFloat#>, bottom: <#T##CGFloat#>, right: <#T##CGFloat#>)
        
        musicButton.frame = FloatRect(self.InfoLabels![6].frame.width + 20, self.InfoLabels![6].frame.origin.y - 5, getWidth(41), getHeight(43))
        musicButton.setImage(#imageLiteral(resourceName: "音乐"), for: .normal)
        musicButton.setImage(#imageLiteral(resourceName: "stopPlay"), for: .selected)
        mapButton.addTarget(self, action: #selector(ppush), for: .touchUpInside)
        //musicButton.backgroundColor = naviColor
 
    }
    

    @objc func ppush(){
        if CLLloaction != nil {
            print(CLLloaction)
         pushDelegate?.Push(vc: MapViewController.init(CLLocation:self.CLLloaction! ))
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
                //print(json)
                
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
                            self.InfoLabels![4].text = "行政区划: " + jj
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
                        
                        
                        
                        self.mapButton.snp.makeConstraints({
                            make in
                            make.left.greaterThanOrEqualTo(self.InfoLabels![3].snp.right);
                            make.width.equalTo(getWidth(100))
                            make.height.equalTo(getHeight(50))
                            make.centerY.equalTo(self.InfoLabels![3])
                        })
                        
                        
                        
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
