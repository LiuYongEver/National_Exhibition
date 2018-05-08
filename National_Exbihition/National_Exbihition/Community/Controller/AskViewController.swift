//
//  AskViewController.swift
//  National_Exbihition
//
//  Created by 刘勇 on 2018/5/6.
//  Copyright © 2018年 shikeTeam. All rights reserved.
//

import UIKit

class AskViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib.init(nibName: "askView", bundle: nil)
        let v = nib.instantiate(withOwner: nil, options: nil)[0] as! askView
        v.frame = self.view.frame
        //self.view.addSubview(v)
        
        let scroll = UIScrollView.init(frame: self.view.frame)
        scroll.addSubview(v)
        scroll.contentSize = CGSize(width:SCREEN_WIDTH,height:SCREEN_HEIGHT*1.3)
        self.view.addSubview(scroll)
        self.navigationItem.title = "发布"

        
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
