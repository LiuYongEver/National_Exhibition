//
//  ChangeInfoViewController.swift
//  National_Exbihition
//
//  Created by 刘勇 on 2018/5/19.
//  Copyright © 2018年 shikeTeam. All rights reserved.
//

import UIKit
import SVProgressHUD
import Alamofire
class ChangeInfoViewController: UIViewController {

    
    lazy var changeInfoView:ChangeInfo = {
        let view = ChangeInfo.init(frame: self.view.frame)
        return view
        
    }()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.changeInfoView.textName.resignFirstResponder()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(changeInfoView)
        self.changeInfoView.changeNow.addTarget(self, action: #selector(changeNow), for: .touchUpInside)
        self.changeInfoView.log_offButton.addTarget(self, action: #selector(log_off), for: .touchUpInside)
        
        
        self.navigationController?.navigationItem.title = "修改个人信息"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func changeNow(){
        
        let url = rootUrl + "/update_userinfo"
        let parame:[String:String] = {
                return ["account":UserDefaults.standard.string(forKey: "account") ?? "","nickname":self.changeInfoView.textName.text!,"sex":"\(self.changeInfoView.sexSegment.selectedSegmentIndex)" ]

            }()

       // print(parame,url)
        //图片
//         let data = UIImageJPEGRepresentation(#imageLiteral(resourceName: "baccc"), 0.5)
//        let imageName = "asdas" + ".png"
        
        Alamofire.upload(
            //同样采用post表单上传
            multipartFormData: { multipartFormData in
                
                for (key,value) in parame{
                    multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
                }
                //服务器地址
        },to: url,encodingCompletion: { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                //json处理
                upload.responseJSON { response in
                    //解包
                   // print(response.result.value)
                    guard let result = response.result.value else { return }
                    print("json:\(result)")
                    let js = JSON(result)
                    if js["status"] == 200 {
                        SVProgressHUD.showSuccess(withStatus: "修改成功")
                        UserDefaults.standard.set(self.changeInfoView.textName.text!, forKey: "nickname")
                        
                        
                        self.present(MyTabViewViewController(), animated: true, completion: nil)
                        
                    }else{
                        SVProgressHUD.showSuccess(withStatus: "修改失败，请检查后重试")

                        
                    }
   
                }
                //上传进度
                upload.uploadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
                    print("图片上传进度: \(progress.fractionCompleted)")
                }
            case .failure(let encodingError):
                print(encodingError)
            }
        })
        
        
        
    }
        
    
    @objc func log_off(){
        UserDefaults.standard.removeObject(forKey: "id")
        UserDefaults.standard.removeObject(forKey: "nickname")

        self.navigationController?.pushViewController(LoginViewController(), animated: true)
        
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
