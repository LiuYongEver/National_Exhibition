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
    
    var country_code:String!
    var database:[String:String]=[
        "geography":"",
        "climate":"",
        "nationName":"",
        "picture":"www.baidu"]
    
    
    
    lazy var textView1:UITextView = {
        let Text = UITextView.init()
        return Text
    }()
    var back:UIScrollView!
    
    
    
    init(frame: CGRect,country_code:String) {
        super.init(frame: frame)
        self.country_code = country_code
        Alarequest()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setText(){
        back = UIScrollView.init(frame: self.frame)
        back.contentSize = CGSize(width:SCREEN_WIDTH,height:SCREEN_HEIGHT*2)
        self.addSubview(back)
        textView1.frame = Rect(33, 473,700, 150)
        textView1.isEditable = false
        textView1.textColor = title2color
        if let gg =  self.database["geography"]{
          let atrString = NSMutableAttributedString.init(string: gg)
           textView1.attributedText = atrString
        }
        back.addSubview(textView1)
        
        let titlelabel = UILabel.init(frame: Rect(23,12, 0, 0))
        titlelabel.font = UIFont.boldSystemFont(ofSize: getHeight(42))
        titlelabel.text = "地理环境"
        titlelabel.sizeToFit()
        back.addSubview(titlelabel)
        
        let Image = UIImageView.init(frame: Rect(105, 77, 540, 364))

        Image.sd_setImage(with: URL.init(string: self.database["picture"]!), placeholderImage: #imageLiteral(resourceName: "baccc"), options: .avoidAutoSetImage, completed: nil)
        back.addSubview(Image)
        let imagelabel = UILabel.init(frame: Rect(327,450,100, 30))
        imagelabel.font = UIFont.systemFont(ofSize: getHeight(26))
        imagelabel.text = self.database["nationName"]
        imagelabel.sizeToFit()
        imagelabel.textColor = title2color
        //imagelabel.backgroundColor = naviColor
        back.addSubview(imagelabel)
        
        let line = UIView.init(frame: FloatRect(0,getHeight(648), SCREEN_WIDTH, getHeight(15)))
        line.backgroundColor = lineColor
        back.addSubview(line)
        
        let titlelabel2 = UILabel.init(frame: Rect(23,12+15, 0, 0))
        titlelabel2.font = UIFont.boldSystemFont(ofSize: getHeight(42))
        titlelabel2.text = "气候环境"
        titlelabel2.sizeToFit()
        line.addSubview(titlelabel2)
       
        let textView2 = UITextView()
        textView2.frame = Rect(33,648+92,700, 150)
        textView2.isEditable = false
        textView2.textColor = title2color
        if let gg =  self.database["climate"]{
            let atrString = NSMutableAttributedString.init(string: gg)
            textView2.attributedText = atrString
        }
        back.addSubview(textView2)
        
        
        let line2 = UIView.init(frame: FloatRect(0,getHeight(167+648+92), SCREEN_WIDTH, getHeight(15)))
        line2.backgroundColor = lineColor
        back.addSubview(line2)
        
        
        let titlelabel3 = UILabel.init(frame: Rect(23,12+15, 0, 0))
        titlelabel3.font = UIFont.boldSystemFont(ofSize: getHeight(42))
        titlelabel3.text = "相关统计"
        titlelabel3.sizeToFit()
        line2.addSubview(titlelabel3)
        
        
        let line3 = UIView.init(frame: FloatRect(0,getHeight(167+648+92+310), SCREEN_WIDTH, getHeight(15)))
        line3.backgroundColor = lineColor
        back.addSubview(line3)
        
        
    }
    
    
    func Alarequest(){
        let url = rootUrl+"/find_nature_pk"
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
                //print(json)
                if let gg = json["data"]["geography"].string{
                    self.database["geography"] = gg
                }
                if let gg = json["data"]["picture"].string{
                    self.database["picture"] = gg
                }
                if let gg = json["data"]["climate"].string{
                    self.database["climate"] = gg
                }
                if let gg = json["data"]["nation_z"].string{
                    self.database["nationName"] = gg
                }

                DispatchQueue.main.async {
                    self.setText()
                }
                

            }
        })
        
        
        
    }
    
   
    
    
}
