//
//  LoginViewController.swift
//  National_Exbihition
//
//  Created by 刘勇 on 2018/4/7.
//  Copyright © 2018年 shikeTeam. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {


    
   
    
    
    
    lazy var LoginView:loginView={
        let view = loginView.init(frame: self.view.frame)
        return view
    }()
   
    
    var countDownTime:Timer?
    
    var  remainSeconds: Int = 0{
        willSet{
            self.LoginView.getCode.setTitle("\(newValue)秒后重新获取", for: .normal)
            self.LoginView.getCode.isEnabled = false
            
            if newValue <= 0 {
                self.LoginView.getCode.setTitle("重新获取", for: .normal)
                self.LoginView.getCode.isEnabled = true
            }
            
        }
    }
    
    
    
    var isCounting = false{
        willSet{
            if newValue {
                countDownTime = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
                remainSeconds = 5
            }
            
        }
    }
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
       setNavi(nav: self.navigationController!)
       self.navigationItem.title = "登录"
        self.setUI()
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

