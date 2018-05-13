//
//  Tableview+Extension.swift
//  National_Exbihition
//
//  Created by 刘勇 on 2018/5/8.
//  Copyright © 2018年 shikeTeam. All rights reserved.
//

import Foundation
extension UITableView{
    
    func autoShowEmptyView(dataSourceCount:Int?){
        self.autoShowEmptyView(title: nil, image: nil, dataSourceCount: dataSourceCount)
    }
    
    func autoShowEmptyView(title:String?,image:UIImage?,dataSourceCount:Int?){
        
        guard let count = dataSourceCount else {
            let empty = EmptyView.init(frame: self.bounds)
            empty.setEmpty(title: title, image: image)
            self.backgroundView = empty
            return
        }
        
        if count == 0 {
            let empty = EmptyView.init(frame: self.bounds)
            empty.setEmpty(title: title, image: image)
            self.backgroundView = empty
        } else {
            self.backgroundView = nil
        }
        
    }
    

    
}

