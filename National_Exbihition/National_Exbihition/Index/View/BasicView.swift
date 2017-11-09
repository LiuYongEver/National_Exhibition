//
//  BasicView.swift
//  National_Exbihition
//
//  Created by ly on 2017/11/9.
//  Copyright © 2017年 shikeTeam. All rights reserved.
//

import Foundation
import UIKit

class BasicView: UIView {
   
    @IBOutlet weak var videoView: UIImageView!
    
    override func draw(_ rect: CGRect) {
        self.videoView.frame = FloatRect(0, 0, SCREEN_WIDTH, getHeight(450))
    }
    

    
}
