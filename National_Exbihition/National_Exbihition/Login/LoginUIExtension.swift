//
//  LoginUIExtension.swift
//  National_Exbihition
//
//  Created by 刘勇 on 2018/5/8.
//  Copyright © 2018年 shikeTeam. All rights reserved.
//

import Foundation
import SVProgressHUD

extension LoginViewController{
    
    
   @objc func updateTime(_timer:Timer){
        remainSeconds -= 1
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.codeText.resignFirstResponder()
        self.phoneText.resignFirstResponder()
        
    }
    
    
    
    func setUI(){
       // self.loginNowButton.layer.cornerRadius = 4
        self.getCodeButton.layer.cornerRadius = 4
        self.phoneText.keyboardType = .numberPad
        self.codeText.keyboardType = .numberPad
        
        self.getCodeButton.titleLabel?.font=UIFont.systemFont(ofSize: getHeight(26))
        getCodeButton.addTarget(self, action: #selector(getCodeRequest), for: .touchUpInside)
        LoginButton.addTarget(self, action: #selector(loginNow), for: .touchUpInside)
       self.view.addSubview(LoginButton)
    }
    
    
  @objc func getCodeRequest(){
        let url = rootUrl + "/getRandomCode"
    if  self.phoneText.text == ""{
        SVProgressHUD.showInfo(withStatus: "请输入手机号")
        SVProgressHUD.dismiss(withDelay: 2)
        return
    }else{
        self.getCodeButton.isEnabled = false
        let phone  = self.phoneText.text
        let paramDic =  ["phoneNums":phone]
        
        AlaRequestManager.shared.postRequest(urlString: url, params: paramDic as [String : AnyObject], success: ({success in
            self.isCounting = true
            if success["status"].int != 200{
                SVProgressHUD.showInfo(withStatus: "失败请重试")
            }

            print(success)
 
        }), failture: ({
            error in
            print(error)

            }
    ))
        
    }
    
    }
    
    
    
    
    
  @objc func loginNow(){
        let url = rootUrl + "/loginUp.do"
        if  self.phoneText.text == "" || self.phoneText.text == "" {
            SVProgressHUD.showInfo(withStatus: "请输入完整")
            SVProgressHUD.dismiss(withDelay: 2)
            return
        }else{
            let phone  = self.phoneText.text!
            let code  = self.codeText.text!

            let paramDic =  ["account":phone,"code":code]
            print(paramDic)
            AlaRequestManager.shared.postRequest(urlString: url, params: paramDic as [String : AnyObject], success: ({success in
                if success["status"].int == 200{
                    print(success)
                    SVProgressHUD.showSuccess(withStatus:  "登录成功")
                    
                    //save info
                    if let nc = success["data"]["nickname"].string{
                        UserDefaults.standard.set(nc, forKey: "nickname")
                    }
                    if let nc = success["data"]["id"].int{
                        UserDefaults.standard.set(nc, forKey: "\(nc)")
                    }
                    if let nc = success["data"]["picture"].int{
                        UserDefaults.standard.set(nc, forKey: "picture")
                    }
                    
                    UserDefaults.standard.set(phone, forKey: "account")
                    UserDefaults.standard.set(code, forKey: "code")

                    
                    
                    
                    
                }else{
                    SVProgressHUD.showInfo(withStatus: success["status"]["data"].string);
                }
                
                self.present(MyTabViewViewController(), animated: true, completion: nil)
                print(success)
                
            }), failture: ({
                error in
                print(error)
                
                }
            ))
            
        }
        
    }
    
    
    
    
    
    
    
    
    
    
}


