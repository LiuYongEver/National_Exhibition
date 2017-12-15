//
//  AboutUsViewController.swift
//  National_Exbihition
//
//  Created by ly on 2017/12/15.
//  Copyright © 2017年 shikeTeam. All rights reserved.
//

import UIKit

class AboutUsViewController: UIViewController {
    
    lazy var buttons:[UIButton] = {
        var buttons = [UIButton]()
        for i in 0...1{
            let but = UIButton()
            but.frame = FloatRect(0, getHeight(264)+getHeight(Double(100*i)), SCREEN_WIDTH, getHeight(101))
            but.layer.borderWidth = getHeight(2)
            but.layer.borderColor = lineColor.cgColor
            but.setTitleColor(title1Color, for: .normal)
            let iimag2 = UIImageView.init(frame: Rect(700, Double(33), 30, 34))
            iimag2.image = #imageLiteral(resourceName: "更多")
            but.addSubview(iimag2)
            buttons.append(but)
        }
        buttons[0].setTitle("帮助", for: .normal)
        buttons[1].setTitle("意见反馈", for: .normal)
        
        return buttons
    }()
    
    lazy var topTitle:UILabel = {
        let ll = UILabel()
        ll.frame = Rect(281,36, 0, 0)
        ll.text = "国情概览"
        ll.font = UIFont.boldSystemFont(ofSize: getHeight(42))
        ll.sizeToFit()
        return ll
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "关于我们"
        self.view.backgroundColor = backColor
        self.view.addSubview(topTitle)
        for i in buttons{
            self.view.addSubview(i)
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
