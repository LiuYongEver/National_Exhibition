//
//  Fans&FocusModel.swift
//  National_Exbihition
//
//  Created by 刘勇 on 2018/5/8.
//  Copyright © 2018年 shikeTeam. All rights reserved.
//

import Foundation


class Funs:NSObject{
    
   @objc var id:String?
   @objc var focusing_nickname:String?
   @objc  var focusingPicture:String?
//    var imageurl:String?
//    var name:String?
    
    init(dict:[String:AnyObject]){
        super.init()
        setValuesForKeys(dict)
        
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        print(key)
    }
    
    class func dictToModel(list:[[String:AnyObject]])->[Funs]{
        var model = [Funs]()
        for dict in list{
            model.append(Funs(dict: dict))
        }
        return model
    }
    
    
    
}
