//
//  MineView.swift
//  National_Exbihition
//
//  Created by ly on 2017/12/4.
//  Copyright © 2017年 shikeTeam. All rights reserved.
//

import UIKit

protocol MineViewDelegate {
    func push(vc:UIViewController)
}


class MineView: UIView {
    
    
    
    var delegate:MineViewDelegate?
    var tableview:UITableView!
    fileprivate var titles = ["我发布的","我的消息","关于我们"]
    var nums = [" \n收藏"," \n关注","\n粉丝"]
    lazy var headerView:UIView = {
        let view = UIView.init(frame: FloatRect(0, 0, SCREEN_WIDTH, getHeight(168+131)))
        view.backgroundColor = backColor
        let line = UIView.init(frame: FloatRect(0, getHeight(167), SCREEN_WIDTH, getHeight(1)))
        line.backgroundColor = lineColor
        view.addSubview(line)
        
        
        view.isUserInteractionEnabled = true

        //无id就已登陆，点击头部跳转到登录，否则跳转到修改个人信息
        if let nick = UserDefaults.standard.string(forKey: "id"){
              print(nick)
            let tap = UITapGestureRecognizer.init(target: self, action: #selector(changeInfo))
            view.addGestureRecognizer(tap)
         
            
        }else{

            let tap = UITapGestureRecognizer.init(target: self, action: #selector(touchHead))
            view.addGestureRecognizer(tap)
            
        }
        

        
        
        return view
    }()
    
    lazy var HeadImgae:UIImageView = {
        let imageView = UIImageView.init(frame: Rect(27, 21, 131, 131))
        imageView.image = #imageLiteral(resourceName: "组 126")
        return imageView
    }()
    
    lazy var userName:UILabel = {
        let label = UILabel.init(frame: Rect(189, 46, 0, 0))
        label.font = UIFont.systemFont(ofSize: getHeight(42))
        label.textColor = title1Color
        return label
    }()
    
    lazy var cell1back:UIView = {
        let view = UIView.init(frame: FloatRect(0,getHeight(168), SCREEN_WIDTH, getHeight(91)))
        view.backgroundColor = backColor
        let line = UIView.init(frame: FloatRect(0, getHeight(157), SCREEN_WIDTH, getHeight(1)))
        line.backgroundColor = lineColor
        view.addSubview(line)
        return view
    }()
    
    
    lazy var collectedButtons:[UIButton]={
        var button = [UIButton]()
        for i in 0...2{
            let btn = UIButton.init(frame: FloatRect(0+(SCREEN_WIDTH/3)*CGFloat(i),0, SCREEN_WIDTH/3, 61))
            btn.titleLabel?.font = UIFont.systemFont(ofSize: getHeight(32))
            btn.tag = i
            btn.addTarget(self, action: #selector(touchFocus(btn:)), for: .touchUpInside)
            button.append(btn)
        }
        
        
        return button
    }()
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setTv()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setTv(){
        self.tableview = UITableView.init(frame: self.frame)
        tableview.dataSource = self
        tableview.delegate = self
        tableview.isScrollEnabled = false
        self.addSubview(tableview)
        tableview.tableFooterView = UIView.init(frame: CGRect.zero)
        

        
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

extension MineView:UITableViewDelegate,UITableViewDataSource{
    
     @objc  func touchHead(){
           self.delegate?.push(vc: LoginViewController())
        
    }

    @objc  func changeInfo(){
        self.delegate?.push(vc: ChangeInfoViewController())
        
    }
    
    
    @objc func touchFocus(btn:UIButton){
        switch btn.tag {
        case 0:
            self.delegate?.push(vc: CollectionTableViewController())
        case 1:
            self.delegate?.push(vc: FocusTableViewController())
        case 2:
            self.delegate?.push(vc: FansTableViewController())
            
        default:
            return
        }
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
        let text = UILabel()
        text.text = titles[indexPath.row]
        text.font = UIFont.systemFont(ofSize: getHeight(32))
        text.textColor = title1Color
        text.frame = Rect(91, 36, 0, 0)
        text.sizeToFit()
       // cell.imageView?.image = #imageLiteral(resourceName: "我的文章")
        let iimag = UIImageView.init(frame: Rect(30, 30, 45, 48))
        iimag.contentMode = .scaleAspectFit
        iimag.image = UIImage.init(named: titles[indexPath.row])
        let iimag2 = UIImageView.init(frame: Rect(700, 33, 30, 34))
        iimag2.image = #imageLiteral(resourceName: "更多")
        cell.addSubview(iimag)
        cell.addSubview(iimag2)
        cell.addSubview(text)
        
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return getHeight(100)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
       return getHeight(168+151)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        userName.text = "昵称"
        if let nick = UserDefaults.standard.string(forKey: "nickname"){
            userName.text = nick
        }
        
        
        userName.sizeToFit()
        headerView.addSubview(HeadImgae)
        headerView.addSubview(userName)
        headerView.addSubview(cell1back)
        for i in self.collectedButtons{
            cell1back.addSubview(i)
            i.setTitleColor(title2color, for: .normal)
            i.setTitle(nums[i.tag], for: .normal)
            i.titleLabel?.numberOfLines = 0
        }
        let line = UIView.init(frame: FloatRect(0, 61, SCREEN_WIDTH,getHeight(10)))
        line.backgroundColor = lineColor
        collectedButtons[0].addSubview(line)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 2{
            delegate?.push(vc:AboutUsViewController())
        }else if indexPath.row == 0{
            delegate?.push(vc: MyPublishTableViewController())
        }
        tableView.cellForRow(at: indexPath)?.isSelected = false
    }
    

    
    
    
}
