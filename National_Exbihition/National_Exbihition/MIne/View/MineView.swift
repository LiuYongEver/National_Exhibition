//
//  MineView.swift
//  National_Exbihition
//
//  Created by ly on 2017/12/4.
//  Copyright © 2017年 shikeTeam. All rights reserved.
//

import UIKit

class MineView: UIView {
    
    var tableview:UITableView!
    fileprivate var titles = ["","我的文章","每日签到","关于我们"]
    var nums = ["23","13","3"]
    lazy var headerView:UIView = {
        let view = UIView.init(frame: FloatRect(0, 0, SCREEN_WIDTH, getHeight(168)))
        view.backgroundColor = backColor
        let line = UIView.init(frame: FloatRect(0, getHeight(167), SCREEN_WIDTH, getHeight(1)))
        line.backgroundColor = lineColor
        view.addSubview(line)
        return view
    }()
    
    lazy var HeadImgae:UIImageView = {
        let imageView = UIImageView.init(frame: Rect(27, 21, 131, 131))
        imageView.image = 头像
        
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
        self.addSubview(tableview)
        
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = titles[indexPath.row]
        cell.imageView?.image = #imageLiteral(resourceName: "我的文章")
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return getHeight(91)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
       return getHeight(168)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    
    
    
}
