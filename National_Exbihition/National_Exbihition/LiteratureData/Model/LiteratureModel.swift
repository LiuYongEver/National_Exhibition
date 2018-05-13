
//
//          childVcs[2] = wenxian .swift
//  National_Exbihition
//
//  Created by 刘勇 on 2018/5/13.
//  Copyright © 2018年 shikeTeam. All rights reserved.
//

import Foundation


class LiteratureModel:NSObject{
    
    @objc var title:String?
    @objc var author:String?
    @objc  var e_book:String?
    
    //Other book
    
    @objc var titleother:String?
    @objc var document_source :String?
    @objc  var document:String?//link
    
    
    //    var imageurl:String?
    //    var name:String?
    
    init(dict:[String:AnyObject]){
        super.init()
        setValuesForKeys(dict)
        
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        print(key)
    }
    
    class func dictToModel(list:[[String:AnyObject]])->[LiteratureModel]{
        var model = [LiteratureModel]()
        for dict in list{
            model.append(LiteratureModel(dict: dict))
        }
        return model
    }
    
    
    
}
