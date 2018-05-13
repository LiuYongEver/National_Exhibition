//
//  CollectionTableViewController.swift
//  National_Exbihition
//
//  Created by 刘勇 on 2018/5/8.
//  Copyright © 2018年 shikeTeam. All rights reserved.
//

import UIKit
import Alamofire

class CollectionTableViewController: UITableViewController {

    
    var funs:[Collect]?{
        didSet{
            
            self.tableView.register(TabTableViewCell.self, forCellReuseIdentifier: "cell")
            self.tableView.reloadData()
            self.tableView.autoShowEmptyView(title: "暂无数据哦！", image: #imageLiteral(resourceName: "空白页"), dataSourceCount: self.funs?.count ?? 0)
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "我的收藏"

        
        loadData()
        self.tableView.tableFooterView = UIView.init(frame: CGRect.zero)
        
    }
    
    
    func loadData(){
        
        let url = rootUrl+"/collection"
        let param = ["userid":"1","page":"0"]
        Alamofire.request(url, method:.post, parameters: param).responseJSON
            {response in
                if let resultDict = response.result.value as? [String:AnyObject]{
                    print(response.result.value)
                    if let lists = resultDict["data"] as? [[String:AnyObject]]{
                        print(lists)
                        //let dic = [["id":"2","focusing_nickname":"1","focusingPicture":"1"]]
                        let models = Collect.dictToModel(list:lists as [[String : AnyObject]])
                        
                        self.funs = models
                        
                    }
                    //print()
                }
                
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.funs?.count ?? 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TabTableViewCell
        
        
        
         cell.nameTitle.text = self.funs?[indexPath.row].question_title
         cell.nameTitle.sizeToFit()
         cell.flagImage.sd_setImage(with: URL.init(string: (self.funs?[indexPath.row].question_picture)!), placeholderImage: #imageLiteral(resourceName: "baccc"))

        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return getHeight(135)
    }
}
