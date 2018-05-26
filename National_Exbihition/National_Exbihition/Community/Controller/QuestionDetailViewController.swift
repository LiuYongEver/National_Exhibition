//
//  QuestionDetailViewController.swift
//  National_Exbihition
//
//  Created by 刘勇 on 2018/4/7.
//  Copyright © 2018年 shikeTeam. All rights reserved.
//

import UIKit

class QuestionDetailViewController: UIViewController {

    
    var id:String = ""
    var vv:QuestionView?
    var DataBase:DetailModel?{
        didSet{
            vv =  QuestionView(frame:self.view.frame,model:DataBase!)
            vv?.focusButton.addTarget(self, action: #selector(focus(_:)), for: .touchUpInside)
            vv?.answerButton.addTarget(self, action: #selector(WriteComment), for: .touchUpInside)
            self.view.addSubview(vv!)
        }
    }
    
   
    var Counts:CountModel!{
        didSet{
            DispatchQueue.main.async {
                self.vv?.changeText(self.Counts)
            }

        }
    }
    
    
    
    init(id:String){
        self.id = id
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        request()
        getCounts()
       //let vview = QuestionView.init(frame: self.view.frame)
       // let nib = UINib.init(nibName: "QuestionView", bundle: nil)


        self.navigationItem.title = "问题详情"
        setNavi(nav: self.navigationController!)
        
        //self.view.addSubview(vview)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func request(){
        
        let url = rootUrl + "/getDetailedQuestion.do"
        let parame:[String:AnyObject] = {
            return ["questionId":id]
            }() as [String : AnyObject]
        
        print(parame)
        AlaRequestManager.shared.POST(urlString: url, params: parame, success: ({
            success in
            print(success)
            if let resultDict = success["data"] as? [String:AnyObject]{
                let model = DetailModel.init(dict: resultDict)
                self.DataBase = model
            }
            
        }))
        
        
    }
    
    
    @objc func goToComment(){
        
    }

    
    //关注
    @objc func focus(_ btn:UIButton){
        
        let url:String = {
            if btn.isSelected{
               btn.isSelected = false
              return rootUrl + "/focus_cancle"
            }else{
                btn.isSelected = true

               return rootUrl + "/focus_customer"
            }
            
        }()
        let parame:[String:AnyObject] = {
            if let us = UserDefaults.standard.string(forKey: "id"){
                return ["focusid":us,"focusedid":self.DataBase!.questioner] as [String : AnyObject]
            }else{
                return [:]
                
            }
            }() as [String : AnyObject]
        
        print(parame)
        AlaRequestManager.shared.POST(urlString: url, params: parame, success: ({
            success in
            print(success)
            //if let resultDict = success["data"] as? [String:AnyObject]{
               // let model = DetailModel.init(dict: resultDict)
                //self.DataBase = model
            //}
            
        }))
    }
    
    @objc func WriteComment(){
          self.navigationController?.pushViewController(WriteCommentViewController.init(id: self.id), animated: true)
    }
    
    
    
    // 获取评论和点赞等数目
    func getCounts(){
        
        let queue = DispatchQueue.init(label: "getCount")//定义队列
        let group = DispatchGroup()//创建一个组
        var nums = CountModel()
        //将队列放进组里
        queue.async(group: group, execute: {
            group.enter()//开始线程1
            
            let url = rootUrl + "/getDisikedNumByQuesitionId.do"
            let parame:[String:AnyObject] = {
                return ["questionId":self.id]
                }() as [String : AnyObject]
            
            AlaRequestManager.shared.POST(urlString: url, params: parame, success: ({success in
               
                 let num = JSON(success)["data"].int ?? 0
                 nums.disLikeCount = num
                
                  group.leave()//线程1结束
            }))
    
        })
        
        
        queue.async(group: group, execute: {
            group.enter()//开始线程2
            
            let url = rootUrl + "/getLikedNumByQuesitionId.do"
            let parame:[String:AnyObject] = {
                return ["questionId":self.id]
                }() as [String : AnyObject]
            
            AlaRequestManager.shared.POST(urlString: url, params: parame, success: ({success in
                let num = JSON(success)["data"].int ?? 0
                nums.likeCount = num
                group.leave()//线程2结束
            }))
        })
        
        
        
        queue.async(group: group, execute: {
            group.enter()//开始线程3
            
            let url = rootUrl + "/getCollectNumByQuesitionId.do"
            let parame:[String:AnyObject] = {
                return ["questionId":self.id]
                }() as [String : AnyObject]
            
            AlaRequestManager.shared.POST(urlString: url, params: parame, success: ({success in
                let num = JSON(success)["data"].int ?? 0
                nums.collectCount = num
                group.leave()//线程3结束
            }))
        })
        
        
        queue.async(group: group, execute: {
            group.enter()//开始线程4
            
            let url = rootUrl + "/getCommentNumByQuesitionId.do"
            let parame:[String:AnyObject] = {
                return ["questionId":self.id]
                }() as [String : AnyObject]
            
            AlaRequestManager.shared.POST(urlString: url, params: parame, success: ({success in
                let num = JSON(success)["data"].int ?? 0
                nums.commentCount = num
                group.leave()//线程3结束
            }))
        })
        
        
        
        group.notify(queue: queue){
            //队列中线程全部结束
            self.Counts = nums
            print("end")
        }
        
        
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
