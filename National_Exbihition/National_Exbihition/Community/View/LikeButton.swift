//
//  LikeButton.swift
//  National_Exbihition
//
//  Created by 刘勇 on 2018/5/26.
//  Copyright © 2018年 shikeTeam. All rights reserved.
//

import UIKit

class LikeButton: UIButton {
    
    
    var countTitle:UILabel!

    
    func setCountTitle(titles:String){
        countTitle = UILabel.init(frame: Rect(60, 0, 60, 26))
        countTitle.textColor = title2color
        countTitle.text = titles
        countTitle.font = UIFont.systemFont(ofSize: getHeight(26))
        self.addSubview(countTitle)
    }
    
    func changeTitle(titles:String){
        countTitle.text = titles
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
