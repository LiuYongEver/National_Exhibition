//
//  ChartDataBase.swift
//  National_Exbihition
//
//  Created by 刘勇 on 2018/5/9.
//  Copyright © 2018年 shikeTeam. All rights reserved.
//

import Foundation
import HandyJSON

class ChartData_Populaton:NSObject{
    
 //   @objc var density:String?
    @objc var id:Int = 0
    @objc var nation_z:String?
    @objc  var mid_year_population:Int = 0
    @objc  var source:String?

    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        //
    }
    
    class func dictToModel(list:[[String:AnyObject]])->[ChartData_Populaton]{
        var model = [ChartData_Populaton]()
        for dict in list{
            model.append(ChartData_Populaton(dict: dict))
        }
        return model
    }
    
    init(dict:[String:AnyObject]){
        super.init()
        
        
        setValuesForKeys(dict)

      //  self.id = UnicodeScalar.init(id)
     }
}

