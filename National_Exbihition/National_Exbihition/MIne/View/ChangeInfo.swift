//
//  ChangeInfo.swift
//  National_Exbihition
//
//  Created by 刘勇 on 2018/5/19.
//  Copyright © 2018年 shikeTeam. All rights reserved.
//

import UIKit

class ChangeInfo: UIView {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(loginbackView)
       // loginbackView.addSubview(logo)
        loginbackView.addSubview(label1)
        loginbackView.addSubview(label2)
        loginbackView.addSubview(textName)
        loginbackView.addSubview(sexSegment)
        
        loginbackView.addSubview(changeNow)
        loginbackView.addSubview(log_offButton)
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
    
    lazy var textName:UITextField = {
        
        let temp = UITextField()
        temp.frame = CGRect(x:getWidth(width: 176),y:getHeight(height: 22+344),width:getWidth(width: 554 - 16),height:getHeight(height: 86))
        temp.backgroundColor = UIColor.white
        temp.layer.borderColor = lineColor.cgColor
        
        temp.layer.cornerRadius = 4
        temp.layer.borderWidth = 1
        
        temp.font = UIFont.systemFont(ofSize: getHeight(height: 32))
        temp.placeholder = "请输入昵称"
        temp.clearButtonMode = UITextFieldViewMode.whileEditing
       // temp.keyboardType = UIKeyboardType.numberPad
        temp.layer.cornerRadius = 7
        return temp
    }()
    lazy var sexSegment:UISegmentedControl = {
        
        let setButton = UISegmentedControl.init(frame: CGRect(x:getWidth(width: 176),y:getHeight(height: 427+52),width:getWidth(width: 352-16),height:getHeight(height: 76)))
        setButton.insertSegment(withTitle: "男", at: 0, animated: true)
        setButton.insertSegment(withTitle: "女", at: 1, animated: true)

        return setButton
    }()
    
    
    lazy var label1 :UILabel = {
        let labelphont = UILabel()
        
        
        labelphont.frame = CGRect(x:getWidth(width: 41),y:getHeight(height: 358+20),width:0,height:0)
        labelphont.font = UIFont.systemFont(ofSize: getHeight(height: 32))
        
        labelphont.text = "昵称"
        labelphont.sizeToFit()
        
        
        return labelphont
    }()
    
    lazy var label2 :UILabel = {
        let labelphont = UILabel()
        labelphont.frame = CGRect(x:getWidth(width: 41),y:getHeight(height: 358+30+110),width:0,height:0)
        labelphont.text = "性别"
        
        labelphont.sizeToFit()
        
        labelphont.font = UIFont.systemFont(ofSize: getHeight(height: 32))
        return labelphont
    }()
    
    
    lazy var changeNow:UIButton  = {
        let button  = UIButton(frame: CGRect(x:getWidth(width: 46),y:getHeight(height: 624+52),width:getWidth(width: 661),height:getHeight(height: 86)))
        button.layer.cornerRadius = 7
        button.setTitle("确认修改", for: .normal)
        button.backgroundColor = naviColor
        return button
    }()
    
    lazy var log_offButton:UIButton  = {
        let button  = UIButton(frame: CGRect(x:getWidth(width: 46),y:getHeight(height: 624+52+184),width:getWidth(width: 661),height:getHeight(height: 86)))
        button.layer.cornerRadius = 7
        button.setTitle("退出登录", for: .normal)
        button.backgroundColor = UIColor.red
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
    
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
