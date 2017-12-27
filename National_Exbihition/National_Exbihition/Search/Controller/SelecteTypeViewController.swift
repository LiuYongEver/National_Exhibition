////
//  SelectContinentTableViewController.swift
//  National_Exbihition
//
//  Created by ly on 2017/12/5.
//  Copyright © 2017年 shikeTeam. All rights reserved.
//

import UIKit



class SelectTypeTableViewController: UITableViewController{

    
    var delegate:selectContinetDelegate?
    
    var selected:String?
    var titles = ["基本信息","环境资源","政治军事","经济发展","社会状况","科技教育","国际关系","侨情"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "选择搜索数据类型"
        self.navigationController?.navigationBar.barTintColor = naviColor
        self.navigationController?.navigationBar.isTranslucent = false
        
        let backbutton = UIButton(type: .custom)
        backbutton.frame = CGRect(x: 0, y: 0, width:68, height: 60)
        //backbutton.setImage(UIImage(named: "back@1x"), for: .normal)
        let bti = UIImageView.init(frame:( CGRect(x:0, y: 13, width: 22, height: 22)))
        bti.image = #imageLiteral(resourceName: "back@1x")
        backbutton.addSubview(bti)
        
        
        backbutton.addTarget(self, action: #selector(touchReturn), for: .touchUpInside)
        let item = UIBarButtonItem(customView: backbutton)
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        barButtonItem.width = -5
        //item.tintColor = UIColor.white
        self.navigationItem.leftBarButtonItems = [barButtonItem,item]
        
    }
    
    func getContinent(str:String){
        delegate?.getContinent(str:str)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func touchReturn(){
        self.dismiss(animated: false, completion: nil)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return titles.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.textColor = title1Color
        cell.textLabel?.text = titles[indexPath.row]
        
        // Configure the cell...
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selected = titles[indexPath.row]
        self.getContinent(str: selected!)
        
        
        self.dismiss(animated: false, completion: nil)
    }
    
    

    
}

