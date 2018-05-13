//
//  CollectModel.swift
//  National_Exbihition
//
//  Created by 刘勇 on 2018/5/9.
//  Copyright © 2018年 shikeTeam. All rights reserved.
//

import Foundation

class Collect:NSObject{
    
    @objc var id:String?
    @objc var question_id:String?
    @objc  var userId:String?
    @objc  var questioner:String?
    @objc  var question_picture:String?
    @objc  var question_title:String?


    init(dict:[String:AnyObject]){
        super.init()
        setValuesForKeys(dict)
        getImageUrl()
        
    }
    
    
    
    func getImageUrl(){
        if  question_picture != "" {
            let fg2 = question_picture?.components(separatedBy: "webapps/")
            let ecc  = imageUrl+fg2![1]
            let eco = ecc.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            self.question_picture = eco
        }
        
        
    }
    
    class func dictToModel(list:[[String:AnyObject]])->[Collect]{
        var model = [Collect]()
        for dict in list{
            model.append(Collect(dict: dict))
        }
        return model
    }
    
    
    
}
