//
//  EnvorinmentViewController.swift
//  National_Exbihition
//
//  Created by ly on 2017/12/13.
//  Copyright © 2017年 shikeTeam. All rights reserved.
//

import UIKit

class EnvrionmentViewController: UIViewController {

    lazy var EnviromentV:UIView = {
        let vie = Environment.init(frame: self.view.frame, country_code: self.contry_code)
        vie.backgroundColor = backColor
        return vie
    }()
    var contry_code = ""
    
    
    init(code:String){
        super.init(nibName: nil, bundle: nil)
        self.contry_code = code
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(EnviromentV)

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
