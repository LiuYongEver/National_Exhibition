//
//  BasicInformationViewController.swift
//  National_Exbihition
//
//  Created by ly on 2017/11/9.
//  Copyright © 2017年 shikeTeam. All rights reserved.
//

import UIKit

class BasicInformationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "BasicView", bundle: nil)
        let v = nib.instantiate(withOwner: nil, options: nil)[0] as! BasicView
        self.view.addSubview(v)
        
        
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
