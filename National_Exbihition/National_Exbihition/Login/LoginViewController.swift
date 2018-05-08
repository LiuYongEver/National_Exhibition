//
//  LoginViewController.swift
//  National_Exbihition
//
//  Created by 刘勇 on 2018/4/7.
//  Copyright © 2018年 shikeTeam. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {


    
    @IBOutlet weak var getCodeButton: UIButton!
    @IBOutlet weak var phoneText: UITextField!
    
    @IBOutlet weak var codeText: UITextField!
   
    lazy var LoginButton:UIButton = {
        let login = UIButton.init(frame:CGRect(x:getWidth(90),y:getHeight(800),width:getWidth(555),height:getHeight(86)))
        login.layer.cornerRadius = 7
        login.backgroundColor = naviColor
        login.setTitleColor(UIColor.white, for: .normal)
        login.setTitle("立即登录", for: .normal)
        login.titleLabel?.font = UIFont.systemFont(ofSize: getHeight(32))
        
        return login
    }()
 
    
    //get code
    
    
    var countDownTime:Timer?
    
    var  remainSeconds: Int = 0{
        willSet{
            self.getCodeButton.setTitle("\(newValue)秒后重新获取", for: .normal)
            self.getCodeButton.isEnabled = false
            
            if newValue <= 0 {
                self.getCodeButton.setTitle("重新获取", for: .normal)
                self.getCodeButton.isEnabled = true
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

