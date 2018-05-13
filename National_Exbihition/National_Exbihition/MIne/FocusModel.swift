//
//  FocusModel.swift
//  National_Exbihition
//
//  Created by 刘勇 on 2018/5/8.
//  Copyright © 2018年 shikeTeam. All rights reserved.
//

import Foundation

class Focus:NSObject{
    
    @objc var id:String?
    @objc var focused_nickname:String?
    @objc  var focused_picture:String?
    //    var imageurl:String?
    //    var name:String?
    
    init(dict:[String:AnyObject]){
        super.init()
        setValuesForKeys(dict)
        
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        print(key)
    }
    
    class func dictToModel(list:[[String:AnyObject]])->[Focus]{
        var model = [Focus]()
        for dict in list{
            model.append(Focus(dict: dict))
        }
        return model
    }
    
    
    
}
