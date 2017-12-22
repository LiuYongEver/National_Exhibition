//
//  RelationshipView.swift
//  National_Exbihition
//
//  Created by ly on 2017/12/17.
//  Copyright © 2017年 shikeTeam. All rights reserved.
//
import Foundation
import UIKit
import Alamofire
import SVProgressHUD

class  RelationshipView:UIView{
    
    var country_code:String!
    var database:[String:String]=[
        "外交政策":"",
        "对外关系简况":"",
        "大国关系（亚洲）":"",
        "大国关系（欧洲）":"",
        "大国关系（非洲）":"",
        "大国关系（大洋洲）":"",
        "大国关系（美洲）":"",
        "大国关系（同中国）":"",
        "同其他国际组织":"",
        "加入的国际框架":"",
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
    
    func getText()->NSMutableAttributedString{
        var atrrString:String  = ""
        let ll = NSMutableAttributedString()
        for (key,value) in self.database{
            if value != ""{
                //print(key)
                if  key == "相关报表" || key == "来源" || key == "重要文献" { continue }
                if value.count>100{
                    ll.append(NumsCountDeal(key: key))
                    continue
                }else{
                    atrrString = atrrString + key + ":  " + value + "\n\n";
                }
            }
            
        }
        
        ll.append(NumsCountDeal(key: "来源"))
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
        let url = rootUrl+"/find_relationship_pk"
        print(country_code)
        let paramete = ["country_code":"\(country_code!)"]
        //print(paramete)
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
                //print(json)
                
                
                if let gg = json["data"]["diplomatic_cpolicy"].string{
                    self.database["外交政策"] = gg
                }
                if let gg = json["data"]["foreign_relation"].string{
                    self.database["对外关系简况"] = gg
                }
                if let gg = json["data"]["big_power_relation_asia"].string{
                    self.database["大国关系（亚洲）"] = gg
                }
                if let gg = json["data"]["big_power_relation_europe"].string{
                    self.database["大国关系（欧洲）"] = gg
                }
                if let gg = json["data"]["big_power_relation_africa"].string{
                    self.database["大国关系（非洲）"] = gg
                }
                if let gg = json["data"]["big_power_relation_oceania"].string{
                    self.database["大国关系（大洋洲）"] = gg
                }
                if let gg = json["data"]["big_power_relation_america"].string{
                    self.database["大国关系（同美洲）"] = gg
                }
                if let gg = json["data"]["big_power_relation_china"].string{
                    self.database["大国关系（同中国）"] = gg
                }
                
                if let gg = json["data"]["relation_international_organization"].string{
                    self.database["同其他国际组织"] = gg
                }
                if let gg = json["data"]["international_agreement"].string{
                    self.database["加入的国际框架"] = gg
                }
                
           
                if let gg = json["data"]["refrence"].string{
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


