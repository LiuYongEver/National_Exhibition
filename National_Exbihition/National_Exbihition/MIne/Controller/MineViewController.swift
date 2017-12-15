//
//  MineViewController.swift
//  National_Exbihition
//
//  Created by ly on 2017/12/4.
//  Copyright © 2017年 shikeTeam. All rights reserved.
//

import UIKit

class MineViewController: UIViewController {
    
    
    fileprivate var mview:MineView!

    override func viewDidLoad() {
        
        mview = MineView.init(frame: self.view.frame)
        mview.delegate = self
        self.view.addSubview(mview)
        self.navigationItem.title = "我的"
        let dict:NSDictionary = [NSAttributedStringKey.foregroundColor: UIColor.white,NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 18)]
        self.navigationController?.navigationBar.barTintColor = naviColor;
        self.navigationController?.navigationBar.isTranslucent = false
        
        //标题颜色
        self.navigationController?.navigationBar.titleTextAttributes = dict as? [NSAttributedStringKey : Any]
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"",style:.plain,target:nil,action:nil);
        super.viewDidLoad()

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
extension MineViewController:MineViewDelegate{
    func push(vc: UIViewController) {
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
