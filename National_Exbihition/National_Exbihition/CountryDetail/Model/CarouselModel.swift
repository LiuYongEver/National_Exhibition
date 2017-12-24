//
//  File.swift
//  National_Exbihition
//
//  Created by ly on 2017/12/24.
//  Copyright © 2017年 shikeTeam. All rights reserved.
//

import Foundation

class CarouselModel:NSObject{
    var title:String = ""
    var pic_url:String = ""
    
    init(dic:[String:NSObject]){
        super.init()
        setValuesForKeys(dic)
    }
    
    override func setValuesForKeys(_ keyedValues: [String : Any]) {
        //
    }
    
    
    
}
