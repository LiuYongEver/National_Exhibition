//
//  EnvironmentView.swift
//  National_Exbihition
//
//  Created by ly on 2017/12/12.
//  Copyright © 2017年 shikeTeam. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SVProgressHUD

class Environment:UIView{
    
    
    let carouselView = CarouselView.init(frame: Rect(105, 77, 540, 364))
    var modelArr = [CarouselModel]()
    var country_code:String!
    var database:[String:String]=[
        "地理环境":"",
        "气候":"",
        "矿产资源":"",
        "生物资源":"",
        "能源资源":"",
        "来源":"",
        "相关报表":"",
        "重要文献":"",
        "图片":"",
        ]
    
    
    
    lazy var textView1:UITextView = {
        let Text = UITextView.init()
        return Text
    }()
    var back:UIView!
    
    
    
    init(frame: CGRect,country_code:String) {
        super.init(frame: frame)
        self.backgroundColor = backColor
        self.country_code = country_code
        Alarequest()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setText(){
        back = UIView.init(frame: self.frame)
        //back.contentSize = CGSize(width:SCREEN_WIDTH,height:SCREEN_HEIGHT*1.2)
        self.addSubview(back)
        
        textView1.isEditable = false
        textView1.textColor = title2color
        //textView1.attributedText = getText();
        textView1.frame = FloatRect(getWidth(0),getHeight(10),SCREEN_WIDTH,SCREEN_HEIGHT-104);
        textView1.bounces = false
        back.addSubview(textView1)
        textView1.attributedText = getText()
        
        
    }
    
    
    func setCarouselView(){
        if (self.database["图片"] != "") {
            
            let imaArr = self.database["图片"]
            let arr =  imaArr?.components(separatedBy: ",")
            for i in arr!{
               let  dataDic = ["i":i]
                modelArr.append(CarouselModel.init(dic: dataDic as [String : NSObject]))
            }
            
            carouselView.carouselModelArr = self.modelArr
            self.textView1.frame =
           self.addSubview(carouselView)
        }
    }
    

    
    
    func getText()->NSMutableAttributedString{
        var atrrString:String  = ""
        let ll = NSMutableAttributedString()
        for (key,value) in self.database{
            if value != ""{
                //print(key)
                if  key == "相关报表" || key == "来源" || key == "重要文献"
                { continue }
                if value.count>100{
                    ll.append(NumsCountDeal(key: key))
                    continue
                }else{
       
                    atrrString = atrrString + key + ":  " + value + "\n\n";
                }
            }
            
        }
        let str = NumsCountDeal(key: "来源");
        ll.append(str)
        ll.append(NumsCountDeal(key: "重要文献"))
        ll.append(NumsCountDeal(key: "相关报表"));
        
        let m = NSMutableAttributedString.init(string: atrrString, attributes:  [NSAttributedStringKey.foregroundColor : title2color, NSAttributedStringKey.font : UIFont.systemFont(ofSize: getHeight(32))])
        m.append(ll)
        
        return m
    }
    
    
    func NumsCountDeal(key:String)->NSMutableAttributedString{
        let IMG  = #imageLiteral(resourceName: "LLine")
        let ttAttach = NSTextAttachment()
        var ll = NSMutableAttributedString()
        ttAttach.image = IMG
        ttAttach.bounds = FloatRect(-10,0,SCREEN_WIDTH,getHeight(15))
        ll.append(NSAttributedString.init(attachment: ttAttach))
        
        let titleatrString = NSAttributedString.init(string: "\(key)\n\n", attributes:  [NSAttributedStringKey.foregroundColor : title1Color, NSAttributedStringKey.font : UIFont.systemFont(ofSize: getHeight(42))])
        ll.append(titleatrString)
        
        if let gg =  self.database[key]{
            
           
            if key == "来源"{
                let array = getUrls(str: gg)
                let titleString = getReFArray(value: gg, url: array)
                print(titleString)
                
                if array.count == titleString.count && titleString.count>0{
                    for i in 0...array.count-1{
                        let reft = NSMutableAttributedString.init(string: titleString[i]+"\n\n", attributes:  [NSAttributedStringKey.foregroundColor : title2color, NSAttributedStringKey.font : UIFont.systemFont(ofSize: getHeight(32))])
                        
                        reft.addAttribute(NSAttributedStringKey.link, value: array[i], range: NSRange.init(location: 0, length:titleString[i].count))
                        ll.append(reft)
                    }
                   return ll
                }
            }
          
            
            let atrString = NSMutableAttributedString.init(string: gg+"\n\n", attributes:  [NSAttributedStringKey.foregroundColor : title2color, NSAttributedStringKey.font : UIFont.systemFont(ofSize: getHeight(32))])
           
            ll.append(atrString)
        }
        return ll
    }
    
    
    func Alarequest(){
        let url = rootUrl+"/find_nature_pk"
       // print(country_code)
        let paramete = ["country_code":"\(country_code!)"]
       // print(paramete)
        Alamofire.request(url, method: .post,parameters:paramete).responseJSON(completionHandler: {
            response in
            if let al = response.response{
                // print(al)
                // print(response.result.isSuccess)
            }else{
                SVProgressHUD.showError(withStatus: "网络连接失败")
                SVProgressHUD.dismiss(withDelay: 1)
            }
            
            if let js = response.result.value{
                let json = JSON(js)//["data"]
                print(json)
                
                
                
                if let gg = json["data"]["geography"].string{
                    self.database["地理环境"] = gg
                }
                if let gg = json["data"]["climate"].string{
                    self.database["气候"] = gg
                }
                if let gg = json["data"]["mineral_resource"].string{
                    self.database["矿产资源"] = gg
                }
                if let gg = json["data"]["biological_resource"].string{
                    self.database["生物资源"] = gg
                }
                if let gg = json["data"]["energy_resource"].string{
                    self.database["能源资源"] = gg
                }
                if let gg = json["data"]["reference"].string{
                    self.database["来源"] = gg
                }
                if let gg = json["data"]["statistics"].string{
                    self.database["相关报表"] = gg
                }
                if let gg = json["data"]["conferences"].string{
                    self.database["重要文献"] = gg
                }
                
                
                DispatchQueue.main.async {
                    self.setText()
                }
                
                
            }
        })
        
        
        
    }
    
    
    
    
}


    
//    var country_code:String!
//    var database:[String:String]=[
//        "geography":"",
//        "climate":"",
//        "nationName":"",
//        "picture":"www.baidu"]
//    
//    
//    
//    lazy var textView1:UITextView = {
//        let Text = UITextView.init()
//        return Text
//    }()
//    var back:UIScrollView!
//    
//    
//    
//    init(frame: CGRect,country_code:String) {
//        super.init(frame: frame)
//        self.country_code = country_code
//        Alarequest()
//        
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    func setText(){
//        back = UIScrollView.init(frame: self.frame)
//        back.contentSize = CGSize(width:SCREEN_WIDTH,height:SCREEN_HEIGHT*2)
//        self.addSubview(back)
//        textView1.frame = Rect(33, 473,700, 150)
//        textView1.isEditable = false
//        textView1.textColor = title2color
//        if let gg =  self.database["geography"]{
//          let atrString = NSMutableAttributedString.init(string: gg, attributes:  [NSAttributedStringKey.foregroundColor : title2color, NSAttributedStringKey.font : UIFont.systemFont(ofSize: getHeight(32))])
//           textView1.attributedText = atrString
//        }
//        back.addSubview(textView1)
//        
//        let titlelabel = UILabel.init(frame: Rect(23,12, 0, 0))
//        titlelabel.font = UIFont.boldSystemFont(ofSize: getHeight(42))
//        titlelabel.text = "地理环境"
//        titlelabel.sizeToFit()
//        back.addSubview(titlelabel)
//        
//        let Image = UIImageView.init(frame: Rect(105, 77, 540, 364))
//
//        Image.sd_setImage(with: URL.init(string: self.database["picture"]!), placeholderImage: #imageLiteral(resourceName: "baccc"), options: .avoidAutoSetImage, completed: nil)
//        back.addSubview(Image)
//        let imagelabel = UILabel.init(frame: Rect(327,450,100, 30))
//        imagelabel.font = UIFont.systemFont(ofSize: getHeight(26))
//        imagelabel.text = self.database["nationName"]
//        imagelabel.sizeToFit()
//        imagelabel.textColor = title2color
//        //imagelabel.backgroundColor = naviColor
//        back.addSubview(imagelabel)
//        
//        let line = UIView.init(frame: FloatRect(0,getHeight(648), SCREEN_WIDTH, getHeight(15)))
//        line.backgroundColor = lineColor
//        back.addSubview(line)
//        
//        let titlelabel2 = UILabel.init(frame: Rect(23,12+15, 0, 0))
//        titlelabel2.font = UIFont.boldSystemFont(ofSize: getHeight(42))
//        titlelabel2.text = "气候环境"
//        titlelabel2.sizeToFit()
//        line.addSubview(titlelabel2)
//       
//        let textView2 = UITextView()
//        textView2.frame = Rect(33,648+92,700, 150)
//        textView2.isEditable = false
//        textView2.textColor = title2color
//        if let gg =  self.database["climate"]{
//            let atrString = NSMutableAttributedString.init(string: gg, attributes:  [NSAttributedStringKey.foregroundColor : title2color, NSAttributedStringKey.font : UIFont.systemFont(ofSize: getHeight(32))])
//            textView2.attributedText = atrString
//        }
//        back.addSubview(textView2)
//        
//        
//        let line2 = UIView.init(frame: FloatRect(0,getHeight(167+648+92), SCREEN_WIDTH, getHeight(15)))
//        line2.backgroundColor = lineColor
//        back.addSubview(line2)
//        
//        
//        let titlelabel3 = UILabel.init(frame: Rect(23,12+15, 0, 0))
//        titlelabel3.font = UIFont.boldSystemFont(ofSize: getHeight(42))
//        titlelabel3.text = "相关统计"
//        titlelabel3.sizeToFit()
//        line2.addSubview(titlelabel3)
//        
//        
//        let line3 = UIView.init(frame: FloatRect(0,getHeight(167+648+92+310), SCREEN_WIDTH, getHeight(15)))
//        line3.backgroundColor = lineColor
//        back.addSubview(line3)
//        
//        
//    }
//    
//    
//    func Alarequest(){
//        let url = rootUrl+"/find_nature_pk"
//        print(country_code)
//        let paramete = ["country_code":"\(country_code!)"]
//        print(paramete)
//        Alamofire.request(url, method: .post,parameters:paramete).responseJSON(completionHandler: {
//            response in
//            if let al = response.response{
//                // print(al)
//                print(response.result.isSuccess)
//            }else{
//                SVProgressHUD.showError(withStatus: "网络连接失败")
//                SVProgressHUD.dismiss(withDelay: 1)
//            }
//            
//            if let js = response.result.value{
//                let json = JSON(js)//["data"]
//                //print(json)
//                if let gg = json["data"]["geography"].string{
//                    self.database["geography"] = gg
//                }
//                if let gg = json["data"]["picture"].string{
//                    self.database["picture"] = gg
//                }
//                if let gg = json["data"]["climate"].string{
//                    self.database["climate"] = gg
//                }
//                if let gg = json["data"]["nation_z"].string{
//                    self.database["nationName"] = gg
//                }
//
//                DispatchQueue.main.async {
//                    self.setText()
//                }
//                
//
//            }
//        })
//        
//        
//        
//    }
//    
//   
//    
//    
//}

