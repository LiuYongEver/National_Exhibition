//
//  LiteratureTableViewController.swift
//  National_Exbihition
//
//  Created by 刘勇 on 2018/5/13.
//  Copyright © 2018年 shikeTeam. All rights reserved.
//


import UIKit
import  Alamofire
import SwiftFCXRefresh
class LiteratureTableViewController: UITableViewController {
    
    private var type:String!
    var page:Int = 0

    
    init(type:String) {
        self.type = type
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var funs:[LiteratureModel]?{
        didSet{
            
         
            self.tableView.reloadData()
            self.tableView.autoShowEmptyView(title: "暂无数据哦！", image: #imageLiteral(resourceName: "空白页"), dataSourceCount: self.funs?.count ?? 0)
            
        }
    }
    
    //刷新
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
        self.navigationItem.title = "我的粉丝"
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell");
        addRefreshView()
        loadData()
        self.tableView.tableFooterView = UIView.init(frame: CGRect.zero)
        
    }
    
    
    func loadData(){
        
        
        
        let url:String = {
            if self.type == "important"{
             return  rootUrl+"/findResearchWorkByLimit"
            }else{
              return rootUrl+"/findLiteratureDataByLimit"
            }
        }()
        let param = ["start":"\(page)"]
        Alamofire.request(url, method:.post, parameters: param).responseJSON
            {response in
                if let resultDict = response.result.value as? [String:AnyObject]{
                    //print(response.result.value)
                    if let lists = resultDict["data"] as? [[String:AnyObject]]{
                 
                        if lists.count == 0{
                            self.footerRefreshView?.showNoMoreData()
                        }
                        
                        let models = LiteratureModel.dictToModel(list:lists)
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

                    }                    //print()
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
        var cell:UITableViewCell?
        cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil{
            cell = UITableViewCell.init(style: .subtitle, reuseIdentifier: "cell")
        }
        
        cell?.textLabel?.numberOfLines = 0;
        cell?.textLabel?.font = UIFont.systemFont(ofSize: getHeight(32))
        cell!.textLabel?.text = {
            if self.type == "important"{
                let t =  "题目： " + (self.funs?[indexPath.row].title ?? "")
                return ( t + "\n作者： " + (self.funs?[indexPath.row].author ?? ""));
            }else{
                
                var t = (self.funs?[indexPath.row].document ?? "")
                let index = t.index(t.startIndex, offsetBy: 31)
                t = String(t[index...])
                //t = t.
                
                return t    //+ "\n" + (self.funs?[indexPath.row].document_source ?? "");
            }
        }()

        //cell!.detailTextLabel?.text = self.funs?[indexPath.row].author
        
        
        return cell!
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return getHeight(135)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
    }
    
    
}
