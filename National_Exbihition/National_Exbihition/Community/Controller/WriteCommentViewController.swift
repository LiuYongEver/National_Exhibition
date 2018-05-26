//
//  WriteCommentViewController.swift
//  National_Exbihition
//
//  Created by 刘勇 on 2018/5/26.
//  Copyright © 2018年 shikeTeam. All rights reserved.
//

import UIKit

class WriteCommentViewController: UIViewController {

    var id:String!
    
    init(id:String) {
        self.id = id
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //UI
    
    lazy var text:UITextView = {
        
        let t = UITextView.init(frame: FloatRect(0, 0, SCREEN_WIDTH, getHeight(758)))
        t.layer.borderWidth = 2
        t.layer.borderColor = lineColor.cgColor
        return t
    }()
    

    lazy var publishButton:UIButton = {
            let button  = UIButton(frame: CGRect(x:getWidth(46),y:getHeight(758+52),width:getWidth(661),height:getHeight(86)))
            button.layer.cornerRadius = 7
            button.setTitle("发布", for: .normal)
            button.backgroundColor = naviColor
            return button
    }()
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.text.resignFirstResponder()
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "发表评论"
        let done = UIBarButtonItem.init(title: "退出编辑", style: .done, target: self, action: #selector(donee))
        self.navigationItem.rightBarButtonItem = done
        
        
        
        self.view.addSubview(text)
        self.view.addSubview(publishButton)
        self.view.backgroundColor = backColor

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @objc func donee(){
        
        self.text.resignFirstResponder()
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
