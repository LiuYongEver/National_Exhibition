//
//  AskViewController.swift
//  National_Exbihition
//
//  Created by 刘勇 on 2018/5/6.
//  Copyright © 2018年 shikeTeam. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

class AskViewController: UIViewController {

    lazy var askView:askView = {
        let nib = UINib.init(nibName: "askView", bundle: nil)
        let v = nib.instantiate(withOwner: nil, options: nil)[0] as! askView
        v.OkButton.addTarget(self, action: #selector(request), for: .touchUpInside)
        return v
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        askView.delegate = self
        askView.frame = self.view.frame
        //self.view.addSubview(v)
        
        let scroll = UIScrollView.init(frame: self.view.frame)
        scroll.delegate = self
        scroll.addSubview(askView)
        scroll.contentSize = CGSize(width:SCREEN_WIDTH,height:SCREEN_HEIGHT*1.3)
        self.view.addSubview(scroll)
        self.navigationItem.title = "发布"

        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @objc func request(){
        let title = "google"//self.askView.titleTet.text!
        let detail = "asd" //self.askView.DetailText.text!
        let image = askView.Image.image
        let nameOfnation = askView.nameOfNation.text!
        let type = self.askView.typeCode
        guard let id = UserDefaults.standard.string(forKey: "id")
            else{
                
                
            SVProgressHUD.showError(withStatus: "用户未登录")
            return
            
        }
        let relevant = askView.relevant ?? "1"
        let picData = UIImageJPEGRepresentation(image ?? #imageLiteral(resourceName: "baccc"), 0.5)
        let url = rootUrl + "/publish"
     let parame:[String:String] = {
            return ["userid":id,"title":title,"content":detail,"country_code":"ARE","data_type":type ?? "0","relevant":relevant]
            
        }()
        
        print(parame,url)
        //图片
              //let data = UIImageJPEGRepresentation(#imageLiteral(resourceName: "baccc"), 0.5)
              let imageName = "liuyong'sTest" + ".png"
        
        Alamofire.upload(
            //同样采用post表单上传
            multipartFormData: { multipartFormData in
                
                for (key,value) in parame{
                    multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
                }
                if image != nil{
                    multipartFormData.append(picData!, withName: "file")
                }
                
                
                //服务器地址
        },to: url,encodingCompletion: { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                //json处理
                upload.responseJSON { response in
                    //解包
                     print(JSON(response.result.value))
                    guard let result = response.result.value else { return }
                    print("json:\(result)")
                    let js = JSON(result)
                    if js["status"] == 200 {
                        SVProgressHUD.showSuccess(withStatus: "发布成功")
                        
                        
                        let vc = MyTabViewViewController()
                        vc.tabBarController?.selectedIndex = 2
                        
                        self.present(vc, animated: true, completion: nil)
                        
                    }else{
                        if let mag = js["data"].string{
                            SVProgressHUD.showError(withStatus:mag)
                        }else{
                          SVProgressHUD.showError(withStatus: "发布失败，请检查后重试")
                        }
                        
                        
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
    
    
    
    
    

}

extension AskViewController:askViewDelegate,UIScrollViewDelegate{
    func present(vc: UIViewController) {
        self.present(vc, animated: true, completion: nil)
    }
    
    func push(vc: UIViewController) {
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.askView.resign()
    }
    

}
