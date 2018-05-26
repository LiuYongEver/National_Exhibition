//
//  LoginView.swift
//  zzcyApp
//
//  Created by zguang on 17/6/19.
//  Copyright © 2017年 zguang. All rights reserved.
//

import Foundation
import UIKit
class loginView:UIView{
    

    override init(frame: CGRect) {
         super.init(frame: frame)
        self.addSubview(loginbackView)
        loginbackView.addSubview(logo)
        loginbackView.addSubview(label1)
        loginbackView.addSubview(label2)
        loginbackView.addSubview(textCode)
        loginbackView.addSubview(textPhone)
        loginbackView.addSubview(getCode)
        
        loginbackView.addSubview(loginNow)
       self.backgroundColor = UIColor.white
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    lazy var loginbackView:UIView = {
        let tempView = UIView()
        tempView.frame = self.frame

        
        return tempView
    }()
    
    lazy var textPhone:UITextField = {
 
        let temp = UITextField()
        temp.frame = CGRect(x:getWidth(width: 176),y:getHeight(height: 22+344),width:getWidth(width: 554 - 16),height:getHeight(height: 86))
        temp.backgroundColor = UIColor.white
        temp.layer.borderColor = lineColor.cgColor

        temp.layer.cornerRadius = 4
        temp.layer.borderWidth = 1

        temp.font = UIFont.systemFont(ofSize: getHeight(height: 32))
        temp.placeholder = "请输入手机号"
        temp.clearButtonMode = UITextFieldViewMode.whileEditing
        temp.keyboardType = UIKeyboardType.numberPad
        temp.layer.cornerRadius = 7
        return temp
    }()
    lazy var textCode:UITextField = {
        
        let temp = UITextField()
        temp.frame = CGRect(x:getWidth(width: 176),y:getHeight(height: 427+52),width:getWidth(width: 352-16),height:getHeight(height: 86))
        
        temp.font = UIFont.systemFont(ofSize: getHeight(height: 32))

        temp.placeholder = "请输入验证码"
        temp.clearButtonMode = UITextFieldViewMode.whileEditing
        temp.keyboardType = UIKeyboardType.numberPad
        temp.returnKeyType = UIReturnKeyType.default
        temp.layer.borderColor = lineColor.cgColor

        temp.layer.borderWidth = 1

        temp.layer.cornerRadius = 7
        return temp
    }()
    
    
    lazy var label1 :UILabel = {
        let labelphont = UILabel()
        
        
        labelphont.frame = CGRect(x:getWidth(width: 41),y:getHeight(height: 358+20),width:0,height:0)
        labelphont.font = UIFont.systemFont(ofSize: getHeight(height: 32))

        labelphont.text = "手机号"
        labelphont.sizeToFit()
        
        
        return labelphont
    }()
    
    lazy var label2 :UILabel = {
        let labelphont = UILabel()
        labelphont.frame = CGRect(x:getWidth(width: 41),y:getHeight(height: 358+30+110),width:0,height:0)
        labelphont.text = "验证码"
       
        labelphont.sizeToFit()

         labelphont.font = UIFont.systemFont(ofSize: getHeight(height: 32))
        return labelphont
    }()
    
    
    
    lazy var getCode:UIButton  = {
        let button  = UIButton(frame: CGRect(x:getWidth(width: 514),y:getHeight(height: 427+52),width:getWidth(width: 194),height:getHeight(height: 86)))
        button.setTitle("获取验证码", for: .normal)
        button.layer.borderColor = lineColor.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 4
        button.titleLabel?.font = UIFont.systemFont(ofSize: getHeight(height: 30))
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.setTitleColor(naviColor, for: .normal)
        return button
    }()
    
    lazy var loginNow:UIButton  = {
        let button  = UIButton(frame: CGRect(x:getWidth(width: 46),y:getHeight(height: 624+52),width:getWidth(width: 661),height:getHeight(height: 86)))
        button.layer.cornerRadius = 7
        button.setTitle("立即登录", for: .normal)
        button.backgroundColor = naviColor
        return button
    }()

    lazy var logo:UIImageView = {
      let image = UIImageView()
      image.frame = CGRect(x:getWidth(width: 151),y:getHeight(height: 107),width:getWidth(width: 450),height:getHeight(height: 110))
        image.image = #imageLiteral(resourceName: "移动端logo")
        

       return image
    }()
    
    

    func getHeight(height: Double) -> CGFloat{
        return CGFloat(height/1334)*(SCREEN_HEIGHT)
    }
    
    func getWidth(width :Double) -> CGFloat {
        return  CGFloat(width/750)*(SCREEN_WIDTH)
    }
    
    
}
