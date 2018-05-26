//
//  MyPublishTableViewController.swift
//  National_Exbihition
//
//  Created by 刘勇 on 2018/5/26.
//  Copyright © 2018年 shikeTeam. All rights reserved.
//

import UIKit
import Alamofire
import SwiftFCXRefresh

class MyPublishTableViewController: UITableViewController {

    
    
    var funs:[MyPublish]?{
        didSet{
            
            self.tableView.register(FansTableViewCell.self, forCellReuseIdentifier: "cell")
            self.tableView.reloadData()
            self.tableView.autoShowEmptyView(title: "暂无数据哦！", image: #imageLiteral(resourceName: "空白页"), dataSourceCount: self.funs?.count ?? 0)
            self.footerRefreshView?.endRefresh()

            
        }
    }
    
    var page:Int = 1
    var footerRefreshView:FCXRefreshFooterView?

    func addRefreshView() {
        footerRefreshView =
            self.tableView.addFCXRefreshFooter { [weak self] (refreshHeader) in
                self?.loadMoreAction()
        }
    }
    
    func loadMoreAction() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) { [weak self] in
            guard let weakSelf = self,
                let _ = self?.footerRefreshView else {
                    //self?.footerRefreshView?.showNoMoreData()
                    return
            }
            weakSelf.page+=1
            weakSelf.loadData()
            // weakSelf.rows += 20
            // self?.tableview.reloadData()
        }
        
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "我的发布"
        
        addRefreshView()
        loadData()
        self.tableView.tableFooterView = UIView.init(frame: CGRect.zero)
        
    }
    
    
    func loadData(){
        
        let url = rootUrl+"/myPublishment"
        let id = UserDefaults.standard.string(forKey: "id") ?? "1"
        let param = ["userid":id,"page":"\(page)"]
        Alamofire.request(url, method:.post, parameters: param).responseJSON
            {response in
                if let resultDict = response.result.value as? [String:AnyObject]{
                    //print(response.result.value)
                    if let lists = resultDict["data"] as? [[String:AnyObject]]{
                        
                        if lists.count == 0{
                            self.footerRefreshView?.showNoMoreData()
                        }
                        
                        let models = MyPublish.dictToModel(list:lists)
                        if self.funs == nil{
                            self.funs = models
                        }else{
                            for i in models{
                                self.funs?.append(i)
                            }
                            self.tableView.reloadData()
                            
                        }
                        self.footerRefreshView?.endRefresh()
                        
                    }else{
                        self.footerRefreshView?.showNoMoreData()
                        
                    }
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
        
        cell.nameLabel.text = self.funs?[indexPath.row].question_title
        cell.headImage.sd_setImage(with: URL.init(string: (self.funs?[indexPath.row].question_picture ?? "") ), placeholderImage: #imageLiteral(resourceName: "baccc"))
        // print(self.funs?[indexPath.row].focusing_nickname)
        
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return getHeight(135)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        let vc = QuestionDetailViewController.init(id: "\(self.funs![indexPath.row].id)")
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
        vc.hidesBottomBarWhenPushed = false

        
    }
    


}
