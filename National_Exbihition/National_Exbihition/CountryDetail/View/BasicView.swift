//
//  BasicView.swift
//  National_Exbihition
//
//  Created by ly on 2017/11/9.
//  Copyright © 2017年 shikeTeam. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import StreamingKit
class BasicView: UIView {
    @IBOutlet weak var playAction: UIButton!
    
    @IBOutlet weak var namelabel: UILabel!
    
    @IBOutlet weak var topview: UIView!
          
    
    @IBAction func playButton(_ sender: Any) {
 
           //audioPlayer.queue("http://www.abstractpath.com/files/audiosamples/sample.mp3");
          // audioPlayer.play("http://www.abstractpath.com/files/audiosamples/sample.mp3")
    }
    
    @IBOutlet weak var videoView: UIImageView!
    
    var InfoLabels:[UILabel]? = [UILabel]()
    var musicButton = UIButton()
    
    
    
    override func draw(_ rect: CGRect) {
        self.videoView.frame = FloatRect(0, 0, SCREEN_WIDTH, getHeight(450))
        videoView.image = #imageLiteral(resourceName: "组 186")
        
        self.playAction.snp.makeConstraints({
            (make) in
               make.width.equalTo(getHeight(100))
               make.height.equalTo(getWidth(100))
               make.center.equalTo(self.videoView.center)
        })
        topview.snp.makeConstraints({
            (make) in
               make.width.equalTo(self.videoView.frame.width)
               make.height.equalTo(getHeight(90))
               make.topMargin.equalTo(0)
        })
        
        self.namelabel.snp.makeConstraints(
            { (make) in
                make.leftMargin.equalTo(getWidth(24))
                make.topMargin.equalTo(getHeight(23))
        })
        namelabel.textColor = UIColor.white
        
        
        for i in 1...7{
            let label = UILabel(frame:Rect(24, 450 + Double(64*i), 0, 0))
            label.font = UIFont.systemFont(ofSize: getHeight(32))
            label.text = "国  名：中华人民共和国（China）"
            
            self.InfoLabels?.append(label)
        }
        
        for i in InfoLabels!{
            i.textColor = title2color
            i.sizeToFit()
            self.superview?.addSubview(i)
        }
        
        self.addSubview(self.musicButton)
        musicButton.frame = FloatRect(self.InfoLabels![6].frame.width, self.InfoLabels![6].frame.origin.y, getWidth(31), getHeight(33))
        
        musicButton.backgroundColor = naviColor
 
        
        
        
        
    }
    

    
}
