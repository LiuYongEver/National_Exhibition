//
//  IndexViewController.swift
//  National_Exbihition
//
//  Created by ly on 2017/11/8.
//  Copyright © 2017年 shikeTeam. All rights reserved.
//

import UIKit

class IndexViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        setPageView()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func  setPageView(){
        var childVcs = [UIViewController]()
        for _ in 0..<4 {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(red: CGFloat(arc4random_uniform(255))/255.0, green: CGFloat(arc4random_uniform(255))/255.0, blue: CGFloat(arc4random_uniform(255))/255.0, alpha: 1.0)
            childVcs.append(vc)
        }
        let title  =  ["推荐","基本信息","自然环境资源","政治军事"]
        let vieww = IndexPageView(frame: self.view.frame,titles: title,child:childVcs,parentViewController: self)
        self.view.addSubview(vieww)
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
