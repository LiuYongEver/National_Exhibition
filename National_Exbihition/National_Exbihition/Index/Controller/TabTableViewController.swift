//
//  TabTableViewController.swift
//  National_Exbihition
//
//  Created by ly on 2017/11/10.
//  Copyright © 2017年 shikeTeam. All rights reserved.
//

import UIKit

class TabTableViewController: UIViewController{
    
    public var dataBase:[String:[String]] = [
        "flag":[],
        "name":[],
        "content":[],
    ]
    
    var index : String?
    
    lazy var changeLocation:UIButton = {
        let button = UIButton(frame:FloatRect(0, 0, SCREEN_WIDTH, getHeight(47)))
        button.setTitle("现在在亚洲，点击选择其他大洲", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: getHeight(26))
        button.setTitleColor(title2color, for: .normal)
        button.layer.borderWidth = getHeight(1)
        button.layer.borderColor = lineColor.cgColor
        button.backgroundColor = backColor
        return button
        
    }()
    
    
    fileprivate var tableview:UITableView?
    
    init(index:String) {
        super.init(nibName: nil, bundle: nil)
        self.index = index
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

    override func viewDidLoad() {
        
        self.view.backgroundColor = UIColor.white
        request()
        setTV()
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func request(){
        for i in 0...5{
        self.dataBase["flag"]?.append("ss")
        self.dataBase["name"]?.append("中国")
        self.dataBase["content"]?.append("国名   中国，是大手笔方法好欺负那可是粉红 i 企鹅放假啊反馈客户问起恢复 i 恶气本菲卡是毕福剑阿富汗 i 前后放假啊什么能发掘并发放 i 啊师傅把沙发")
        }
    }
    
    func setTV(){
        self.tableview = UITableView(frame:self.view.frame)
        tableview?.delegate = self
        tableview?.dataSource = self
        self.view.addSubview(tableview!)
        
        
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

extension TabTableViewController:UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.dataBase["name"]?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TabTableViewCell(style: .default ,reuseIdentifier:"cell")
        cell.flagImage.image = #imageLiteral(resourceName: "组 3")
        cell.nameTitle.text = (self.dataBase["name"]?[indexPath.row])! + "   \(self.index!)"
        cell.nameTitle.sizeToFit()
        cell.contentLabel.text = self.dataBase["content"]?[indexPath.row]
        //cell.contentLabel.sizeToFit()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return getHeight(135)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return getHeight(47)
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return changeLocation
    
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nav = UINavigationController(rootViewController:BasicInformationViewController(title:(self.dataBase["name"]?[indexPath.row])!))
        self.present(nav, animated: true, completion: nil)
        
    }
    
    
    
    
}
