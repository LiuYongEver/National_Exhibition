//
//  QuestionView.swift
//  National_Exbihition
//
//  Created by 刘勇 on 2018/4/7.
//  Copyright © 2018年 shikeTeam. All rights reserved.
//

import UIKit

class QuestionView: UIView {


    var database:DetailModel!
    
    
    lazy var upView:UIView={
        let view = UIView.init(frame:FloatRect(0, 0, SCREEN_WIDTH, getHeight(185)))
        view.backgroundColor = UIColor.white
        
        let viewLine = UIView.init(frame: FloatRect(0,getHeight(168), SCREEN_WIDTH, getHeight(185-168)))
        viewLine.backgroundColor = lineColor
        view.addSubview(viewLine)
        return view
    }()
    
    lazy var bottomView:UIView={
        let view = UIView.init(frame:FloatRect(0, getHeight(185), SCREEN_WIDTH, SCREEN_HEIGHT - getHeight(185)))
        view.backgroundColor = UIColor.white

        return view
        
    }()
    
    lazy var commentView:UIView={
        let view = UIView.init(frame:FloatRect(0,getHeight(880), SCREEN_WIDTH,getHeight(70)))
        view.backgroundColor = UIColor.white
        
        return view
        
    }()

    lazy var titleLabel:UILabel={
    
        let label = UILabel(frame: Rect(30, 24, 674, 79))
        label.font = UIFont.systemFont(ofSize: getHeight(32))
        label.numberOfLines = 0
        label.textColor = title1Color
        label.text = self.database.question_title
        label.sizeToFit()
        
        return label
    }()
   
    lazy var  answerButton:UIButton={
        let button = UIButton(frame: Rect(601,108,121,48))
        button.setTitle("写回答", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: getHeight(26))
        button.backgroundColor = UIColor.init(red: 222/255, green: 238/255, blue: 246/255, alpha: 1)
        button.setTitleColor(naviColor, for: .normal)
        return button
    }()
    
    
    lazy var  tagLabel:UILabel={
        let label = UILabel(frame: Rect(30,116,674, 79))
        label.font = UIFont.systemFont(ofSize: getHeight(26))
        label.textColor = naviColor
//        let text = ["基本信息","环境资源","政治军事","经济发展","社会状况","科技教育","国际关系","侨情"]
        label.text = self.database.data_type
        
        
        
        label.sizeToFit()
        // label.numberOfLines = 0
        return label
    }()
    
    
    lazy var userImage:UIImageView={
        let l = UIImageView(frame: Rect(30,18,80, 80))
        l.layer.cornerRadius = 40
        l.image = #imageLiteral(resourceName: "baccc")
        return l
    }()
    
    
    lazy var userName:UILabel = {
        
        let label = UILabel(frame: Rect(30+90,46,100,26))
        label.font = UIFont.systemFont(ofSize: getHeight(26))
        label.textColor = title1Color
        label.text = self.database.nickName ?? ""
        label.sizeToFit()
        
        return label
    }()
    
    
    lazy var  focusButton:UIButton={
        let button = UIButton(frame: Rect(601,32,121,48))
        button.setTitle("+ 关注", for: .normal)
        button.setTitle("已关注", for: .selected)
        button.titleLabel?.font = UIFont.systemFont(ofSize: getHeight(26))
        button.backgroundColor = UIColor.init(red: 222/255, green: 238/255, blue: 246/255, alpha: 1)
        button.setTitleColor(naviColor, for: .normal)
        return button
    }()
    
    
    lazy var contentText:UITextView={
        let l = UITextView(frame: Rect(0,106,750,820))
        
        var ll = NSMutableAttributedString()

        
        if let IMG  = self.database.question_picture{
          
             var eco:String = IMG//.removingPercentEncoding ?? ""
             let url = getSomeImageURL(image: eco)
            let ttAttach = NSTextAttachment()
            do{
              var data = try Data(contentsOf: url)
              ttAttach.image = UIImage.init(data: data)
             ll.append(NSAttributedString.init(attachment: ttAttach))
            }catch {
                print(error)
            }
        }
        
        let titleatrString = NSAttributedString.init(string: self.database.question_description ?? "", attributes:  [NSAttributedStringKey.foregroundColor : title1Color, NSAttributedStringKey.font : UIFont.systemFont(ofSize: getHeight(26))])
        
        ll.append(titleatrString)
        
        l.isEditable = false
        l.attributedText = ll
       // l.bounces = true
       // l.image = #imageLiteral(resourceName: "baccc")
       // l.contentMode = .scaleAspectFit
        return l
    }()
    
    //点赞等button
    
    
    lazy var  dislikeButton:LikeButton={
        let button = LikeButton(frame: Rect(263,17,120,36))

       // button.frame = CGRect(x:getWidth(255),y:getHeight(15),width:getWidth(100),height:getHeight(41))
        // videoCount.titleLabel?.adjustsFontSizeToFitWidth = true
        button.setTitleColor(UIColor.black, for: .normal)
       // button.titleEdgeInsets = UIEdgeInsets.init(top: 0, left:0, bottom: 0, right: 0)
        button.titleLabel?.font = UIFont.systemFont(ofSize: getHeight(26))
        button.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: 0 , bottom: 0, right: getWidth(84))
        button.setImage(#imageLiteral(resourceName: "critic2"), for: .normal)
        button.setImage(#imageLiteral(resourceName: "critic1"), for: .selected)

       // button.setTitle("62", for: .normal)
        button.setCountTitle(titles: "0")
      
        button.tag = 1;
        
       // button.backgroundColor = UIColor.init(red: 222/255, green: 238/255, blue: 246/255, alpha: 1)
        //button.setTitleColor(naviColor, for: .normal)
        return button
    }()
    lazy var  likeButton:LikeButton={
        let button = LikeButton(frame: Rect(263+130,17,120,36))
        button.imageEdgeInsets = UIEdgeInsets.init(top: 0, left:0 , bottom: 0, right:getWidth(84))
        button.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: getWidth(49), bottom: 0, right: 0)
        button.setImage(#imageLiteral(resourceName: "zan2"), for: .normal)
        button.setImage(#imageLiteral(resourceName: "zan1"), for: .selected)
        button.titleLabel?.font = UIFont.systemFont(ofSize: getHeight(26))
        button.setTitleColor(title2color, for: .normal)
        button.setCountTitle(titles: "0")

        button.tag = 2;

        return button
    }()
    lazy var  collectButton:LikeButton={
        let button = LikeButton(frame: Rect(263+130*2,17,120,36))
        button.imageEdgeInsets = UIEdgeInsets.init(top: 0, left:0 , bottom: 0, right:getWidth(84))
        button.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: getWidth(49), bottom: 0, right: 0)
        button.setImage(#imageLiteral(resourceName: "collect2"), for: .normal)
        button.setImage(#imageLiteral(resourceName: "collect1"), for: .selected)
        button.titleLabel?.font = UIFont.systemFont(ofSize: getHeight(26))
        button.setTitleColor(title2color, for: .normal)
        button.setCountTitle(titles: "0")

        button.tag = 3;

        
        // button.backgroundColor = UIColor.init(red: 222/255, green: 238/255, blue: 246/255, alpha: 1)
        //button.setTitleColor(naviColor, for: .normal)
        return button
    }()
    lazy var  commentButton:LikeButton={
        let button = LikeButton(frame: Rect(263+130*3,17,120,36))
        button.imageEdgeInsets = UIEdgeInsets.init(top: 0, left:0 , bottom: 0, right:getWidth(84))
        button.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: getWidth(49), bottom: 0, right: 0)
        button.setCountTitle(titles: "0")
        button.setImage(#imageLiteral(resourceName: "comment2"), for: .normal)
        button.setImage(#imageLiteral(resourceName: "comment1"), for: .selected)
        button.titleLabel?.font = UIFont.systemFont(ofSize: getHeight(26))
        button.tag = 4;

        // button.backgroundColor = UIColor.init(red: 222/255, green: 238/255, blue: 246/255, alpha: 1)
        button.setTitleColor(title2color, for: .normal)
        return button
    }()
    
    
    
    
    
    func changeText(_ m:CountModel){
        dislikeButton.changeTitle(titles: "\(m.disLikeCount)")
        likeButton.changeTitle(titles: "\(m.likeCount)")
        collectButton.changeTitle(titles: "\(m.collectCount)")
        commentButton.changeTitle(titles: "\(m.commentCount)")
    }
    
    
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    
     init(frame: CGRect,model:DetailModel) {
        super.init(frame: frame)
        self.database = model
        self.upView.addSubview(titleLabel)
        self.upView.addSubview(tagLabel)
        upView.addSubview(answerButton)
       // upView.addSubview(dislikeButton)
        
        bottomView.addSubview(userName)
        bottomView.addSubview(userImage)
        bottomView.addSubview(focusButton)
        bottomView.addSubview(contentText)
       // bottomView.addSubview(dislikeButton)
        
        self.addSubview(upView)
        self.addSubview(bottomView)
        bottomView.addSubview(commentView)
        commentView.addSubview(dislikeButton)
        commentView.addSubview(likeButton)
        commentView.addSubview(collectButton)
        commentView.addSubview(commentButton)
        self.backgroundColor = backColor
        
        

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func draw(_ rect: CGRect) {

    
        // Drawing code
    }


}
