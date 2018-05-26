//
//  FocusTableViewController.swift
//  National_Exbihition
//
//  Created by 刘勇 on 2018/5/8.
//  Copyright © 2018年 shikeTeam. All rights reserved.
//

import UIKit
import Alamofire


protocol  getFocusListDelegate {
    func getFocus(name:String,id:Int)
}





class FocusTableViewController: UITableViewController {
   
    
    var getFoucsdelegate:getFocusListDelegate?

    var funs:[Focus]?{
        didSet{
            
            self.tableView.register(FansTableViewCell.self, forCellReuseIdentifier: "cell")
            self.tableView.reloadData()
            self.tableView.autoShowEmptyView(title: "暂无数据哦！", image: #imageLiteral(resourceName: "空白页"), dataSourceCount: self.funs?.count ?? 0)
            
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "我的关注"

        
        loadData()
        self.tableView.tableFooterView = UIView.init(frame: CGRect.zero)
        
    }
    
    
    func loadData(){
        
        let url = rootUrl+"/focus"
        let id = UserDefaults.standard.string(forKey: "id") ?? "1"
        let param = ["userid":id]
        Alamofire.request(url, method:.post, parameters: param).responseJSON
            {response in
                if let resultDict = response.result.value as? [String:AnyObject]{
                    // print(response.result.value)
                    if let lists = resultDict["data"] as? [[String:AnyObject]]{
                        print(lists)
                        //let dic = [["id":"2","focusing_nickname":"1","focusingPicture":"1"]]
                        let models = Focus.dictToModel(list:lists as [[String : AnyObject]])
                        
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FansTableViewCell
        //let cell = TabTableViewCell(style: .default ,reuseIdentifier:"cell")
        
        cell.nameLabel.text = self.funs?[indexPath.row].focused_nickname
        cell.headImage.sd_setImage(with: URL.init(string: (self.funs?[indexPath.row].focused_picture ?? "") ), placeholderImage: #imageLiteral(resourceName: "baccc"))
        // print(self.funs?[indexPath.row].focusing_nickname)
        
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return getHeight(135)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if self.getFoucsdelegate != nil {
            self.getFoucsdelegate?.getFocus(name: self.funs![indexPath.row].focused_nickname ?? " ", id: self.funs![indexPath.row].id)
            self.navigationController?.popViewController(animated: true)
            
        }
        
        
    }


}






