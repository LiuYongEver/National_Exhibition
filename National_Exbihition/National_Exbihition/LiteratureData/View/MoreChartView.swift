//
//  MoreChartView.swift
//  National_Exbihition
//
//  Created by ly on 2017/11/30.
//  Copyright © 2017年 shikeTeam. All rights reserved.
//

import UIKit

class MoreChartView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        for i in self.texts{
            self.backView.addSubview(i)
        }
        
        self.addSubview(backView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var backView:UIView = {
        let view = UIView.init(frame: self.frame)

        let titles = ["大洲","类型","国家","时间","类型"]
        for i in 0...4{
            let label1 = UILabel.init(frame: Rect(20,Double(47+87*i),0,0));
            label1.text = titles[i];
            label1.textColor = title2color;
            label1.font  = UIFont.systemFont(ofSize: getHeight(32));
            label1.sizeToFit();
            view.addSubview(label1)
        }
    
        return view
    }()
    
    lazy var texts:[UIButton] = {
        var button = [UIButton]()
        for i in 0...5{
            let btn = UIButton(frame:Rect(118, Double(30+90*i), 603, 65))
            btn.setTitle("请选择", for: .normal)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: getHeight(26))
            btn.setTitleColor(title2color,for:.normal)
            btn.layer.cornerRadius = 3
            btn.layer.borderWidth = 1
            btn.layer.borderColor = lineColor.cgColor
            btn.tag = i
            button.append(btn)
            //self.backView.addSubview(button[i])
        }
        return button
    }()
    
    
      

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
