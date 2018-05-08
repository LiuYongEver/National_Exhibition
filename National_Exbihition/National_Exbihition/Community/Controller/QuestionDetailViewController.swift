//
//  QuestionDetailViewController.swift
//  National_Exbihition
//
//  Created by 刘勇 on 2018/4/7.
//  Copyright © 2018年 shikeTeam. All rights reserved.
//

import UIKit

class QuestionDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       //let vview = QuestionView.init(frame: self.view.frame)
       // let nib = UINib.init(nibName: "QuestionView", bundle: nil)
        let v =  QuestionView(frame:self.view.frame)
        
        self.navigationItem.title = "问题详情"
        self.view.addSubview(v)
        
        //self.view.addSubview(vview)
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
