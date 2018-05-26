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
        self.LoginView.textPhone.resignFirstResponder()
       self.LoginView.textCode.resignFirstResponder()
        
    }
    
    
    
    func setUI(){

       LoginView.getCode.addTarget(self, action: #selector(getCodeRequest), for: .touchUpInside)
       LoginView.loginNow.addTarget(self, action: #selector(loginNow), for: .touchUpInside)
        self.view.addSubview(LoginView)
    }
    
    
  @objc func getCodeRequest(){
        let url = rootUrl + "/getRandomCode"
    if  self.LoginView.textPhone.text == ""{
        SVProgressHUD.showInfo(withStatus: "请输入手机号")
        SVProgressHUD.dismiss(withDelay: 2)
        return
    }else{
        self.LoginView.getCode.isEnabled = false
        let phone  = self.LoginView.textPhone.text
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
        let url = rootUrl + "/loginUp"
        if  self.LoginView.textCode.text == "" || self.LoginView.textPhone.text == "" {
            SVProgressHUD.showInfo(withStatus: "请输入完整")
            SVProgressHUD.dismiss(withDelay: 2)
            return
        }else{
            let phone  = self.LoginView.textPhone.text!
            let code  =  self.LoginView.textCode.text!

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
                        UserDefaults.standard.set("\(nc)", forKey: "id")
                    }
                    if let nc = success["data"]["picture"].int{
                        UserDefaults.standard.set(nc, forKey: "picture")
                    }
                    
                    UserDefaults.standard.set(phone, forKey: "account")
                    UserDefaults.standard.set(code, forKey: "code")
                    self.present(MyTabViewViewController(), animated: true, completion: nil)
                    
                    
                    
                    
                }else{
                    SVProgressHUD.showInfo(withStatus: success["status"]["data"].string);
                }
                

                print(success)
                print(UserDefaults.standard.string(forKey: "id"))
                
            }), failture: ({
                error in
                print(error)
                
                }
            ))
            
        }
        
    }
    
    
    
    
    
    
    
    
    
    
}


