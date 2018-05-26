//
//  MyPublishModel.swift
//  National_Exbihition
//
//  Created by 刘勇 on 2018/5/26.
//  Copyright © 2018年 shikeTeam. All rights reserved.
//

import Foundation

class MyPublish:NSObject{
    
    @objc var id:Int = 0
    @objc var question_title:String?
    @objc  var question_picture:String?
    @objc  var nickName:String?
    //    var imageurl:String?
    //    var name:String?
    
    init(dict:[String:AnyObject]){
        super.init()
        setValuesForKeys(dict)
        
        
        
        
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        print(key)
    }
    
    
    class func dictToModel(list:[[String:AnyObject]])->[MyPublish]{
        var model = [MyPublish]()
        for dict in list{
            model.append(MyPublish(dict: dict))
        }
        return model
    }
    
    
    
}
