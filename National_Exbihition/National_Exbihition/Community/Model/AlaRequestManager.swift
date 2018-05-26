//
//  AlaRequestManager.swift
//  shikeClass
//
//  Created by 刘勇 on 2018/3/24.
//  Copyright © 2018年 shikeTeam. All rights reserved.
//网络请求类库的封装

import Foundation
import Alamofire
class AlaRequestManager{
    
    // 请求单例
    static let shared:AlaRequestManager = {
        let m = AlaRequestManager()
        return m;
    }()
    
    func postRequest(urlString : String, params : [String : AnyObject], success : @escaping (_ responseObject : JSON)->(), failture : @escaping (_ error : NSError)->()) {
        
        
      //  let headers = ["Content-Type":"a566eb03378211f7dc9ff15ca78c2d93"]

        
        Alamofire.request(urlString, method:.post, parameters: params, encoding: URLEncoding.httpBody, headers: nil).responseJSON
            {response in
                
                
                print(response.request)
                if  response.result.isSuccess {
                    if let value = response.result.value{
                        
                        
                        success(JSON(value))
                    }
                }else{
                    let error = response.result.error
                    print(error)
                    failture(error! as NSError)
                    
                }
        }
    }
    
    
    func POST(urlString : String, params : [String : AnyObject], success : @escaping (_ responseObject : [String:AnyObject])->()) {
   
        
        Alamofire.request(urlString, method:.post, parameters: params).responseJSON
            {response in
                 print(response.request?.httpBodyStream)
                if  response.result.isSuccess {
                    if let value = response.result.value{
                        success(value as! [String : AnyObject])
                    }
                }else{
                    let error = response.result.error.debugDescription
                    print(error ?? " ")
                    
                }
        }
    }
    

    func oriRequest(){
        let myUrl = URL(string: "http://112.74.36.246:8080/nation/api/update_userinfo");
        var request = URLRequest(url:myUrl!);
        request.httpMethod = "POST";
        request.addValue("multipart/from-data", forHTTPHeaderField: "Content-Type")
        
        let postString = "account=18850076841&nickname=222&sex=0";
        request.httpBody = postString.data(using: String.Encoding.utf8);
        
        print(request.httpBody as Any)
        
        
        URLSession.shared.dataTask(with: request, completionHandler: { (data:Data?, response:URLResponse?, error:Error?) -> Void in
            
            
   
            
            if error != nil {
                print("fail")
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
               // print ("1")
                print(JSON(data))

                
                if let parseJSON = json {
                }
                    
            } catch{
                print(error)
            }
        }).resume()
    }
    
    
    
    
    
}
