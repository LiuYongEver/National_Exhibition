//
//  EconomicView.swift
//  National_Exbihition
//
//  Created by ly on 2017/12/13.
//  Copyright © 2017年 shikeTeam. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SVProgressHUD

class EconomicView:UIView{
    
    var country_code:String!
    var database:[String:String]=[
        "现任首脑":"",
        "就任时间":"",
        "宪法":"",
        "政府机关":"",
        "政体":"",
        "议会":"",
        "政治人物":"",
        "军事概览":"",
        ]
    
    
    
    lazy var textView1:UITextView = {
        let Text = UITextView.init()
        return Text
    }()
    var back:UIView!
    
    
    
    init(frame: CGRect,country_code:String) {
        super.init(frame: frame)
        self.country_code = country_code
        Alarequest()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*
     - parameter textView:   UITextView
     - parameter fixedWidth:      UITextView宽度
     - returns:              返回UITextView的高度
     */
    func heightForTextView(textView: UITextView, fixedWidth: CGFloat) -> CGFloat {
        let size = CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude)
        let constraint = textView.sizeThatFits(size)
        return constraint.height
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
        
        let IMG  = #imageLiteral(resourceName: "组 183")
        let ttAttach = NSTextAttachment()
        ttAttach.image = IMG
        ttAttach.bounds = FloatRect(-10,0,SCREEN_WIDTH,getHeight(15))
        var ll = getText()
        ll.append(NSAttributedString.init(attachment: ttAttach))
        
        let titleatrString = NSAttributedString.init(string: "政治人物\n", attributes:  [NSAttributedStringKey.foregroundColor : title1Color, NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: getHeight(42))])
        ll.append(titleatrString)
        
        if let gg =  self.database["政治人物"]{
            let atrString = NSMutableAttributedString.init(string: gg+"\n\n", attributes:  [NSAttributedStringKey.foregroundColor : title2color, NSAttributedStringKey.font : UIFont.systemFont(ofSize: getHeight(32))])
            ll.append(atrString)
        }
        
        
        ll.append(NSAttributedString.init(attachment: ttAttach))
        
        let titleatrString2 = NSAttributedString.init(string: "军事概览\n", attributes:  [NSAttributedStringKey.foregroundColor : title1Color, NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: getHeight(42))])
        ll.append(titleatrString2)
        
        if let gg =  self.database["军事概览"]{
            let atrString = NSMutableAttributedString.init(string: gg+"\n", attributes:  [NSAttributedStringKey.foregroundColor : title2color, NSAttributedStringKey.font : UIFont.systemFont(ofSize: getHeight(32))])
            ll.append(atrString)
        }
        
        
        textView1.attributedText = ll
        
        
        
        
        
        
        let line = UIView.init(frame: FloatRect(0,getHeight(600), SCREEN_WIDTH, getHeight(15)))
        line.backgroundColor = lineColor
        // back.addSubview(line)
        //        line.snp.makeConstraints({
        //            make in
        //               make.top.greaterThanOrEqualTo(self.center)
        //               make.width.equalTo(SCREEN_WIDTH)
        //               make.height.equalTo(15)
        //        })
        
        
        let titlelabel2 = UILabel.init(frame: Rect(23,12+15, 0, 0))
        titlelabel2.font = UIFont.boldSystemFont(ofSize: getHeight(42))
        titlelabel2.text = "政治人物"
        titlelabel2.sizeToFit()
        //line.addSubview(titlelabel2)
        
        let textView2 = UITextView()
        textView2.frame = FloatRect(getWidth(33),(600+82),SCREEN_HEIGHT, 150+58)
        textView2.isEditable = false
        textView2.textColor = title2color
        if let gg =  self.database["政治人物"]{
            let atrString = NSMutableAttributedString.init(string: gg, attributes:  [NSAttributedStringKey.foregroundColor : title2color, NSAttributedStringKey.font : UIFont.systemFont(ofSize: getHeight(32))])
            textView2.attributedText = atrString
        }
        //back.addSubview(textView2)
        
        
        let line2 = UIView.init(frame: FloatRect(0,getHeight(167+648+92), SCREEN_WIDTH, getHeight(15)))
        line2.backgroundColor = lineColor
        //back.addSubview(line2)
        
        
        let titlelabel3 = UILabel.init(frame: Rect(23,12+15, 0, 0))
        titlelabel3.font = UIFont.boldSystemFont(ofSize: getHeight(42))
        titlelabel3.text = "军事概览"
        titlelabel3.sizeToFit()
        line2.addSubview(titlelabel3)
        
        
        let line3 = UIView.init(frame: FloatRect(0,getHeight(167+648+92+310), SCREEN_WIDTH, getHeight(15)))
        line3.backgroundColor = lineColor
        back.addSubview(line3)
        
        
    }
    
    func getText()->NSMutableAttributedString{
        var atrrString:String  = ""
        for (key,value) in self.database{
            if key == "政治人物" || key == "军事概览"{
                continue
            }
            if value != ""{
                atrrString = atrrString + key + ":  " + value + "\n\n"
            }
        }
        
        return NSMutableAttributedString.init(string: atrrString, attributes:  [NSAttributedStringKey.foregroundColor : title2color, NSAttributedStringKey.font : UIFont.systemFont(ofSize: getHeight(32))])
    }
    
    
    func Alarequest(){
        let url = rootUrl+"/find_politic_pk"
        print(country_code)
        let paramete = ["country_code":"\(country_code!)"]
        print(paramete)
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
                let json = JSON(js)//["data"]
                print(json)
                if let gg = json["data"]["leader"].string{
                    self.database["现任首脑"] = gg
                }
                if let gg = json["data"]["office_time"].string{
                    self.database["就任时间"] = gg
                }
                if let gg = json["data"]["parliament"].string{
                    self.database["宪法"] = gg
                }
                if let gg = json["data"]["government"].string{
                    self.database["政府机关"] = gg
                }
                if let gg = json["data"]["political_persons"].string{
                    self.database["政治人物"] = gg
                }
                if let gg = json["data"]["military"].string{
                    self.database["军事概览"] = gg
                }
                
                
                DispatchQueue.main.async {
                    self.setText()
                }
                
                
            }
        })
        
        
        
    }
    
    
    
    
}

