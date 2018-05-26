//
//  DetailModel.swift
//  National_Exbihition
//
//  Created by 刘勇 on 2018/5/24.
//  Copyright © 2018年 shikeTeam. All rights reserved.
//

import Foundation

struct CountModel {
    var commentCount:Int = 0;
    var collectCount:Int = 0;
    var likeCount:Int = 0;
    var disLikeCount:Int = 0;
}



class DetailModel:NSObject{
    
    @objc var questioner:Int = 0
    @objc var question_title:String?
    @objc  var question_description:String?
    @objc  var question_picture:String?
    @objc  var question_date_time:Int = 0
    @objc  var country_name_z:String?
    @objc  var data_type:String?
    @objc  var nickName:String?

    init(dict:[String:AnyObject]){
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        print(key)
    }
    
    
    
    
    
}
