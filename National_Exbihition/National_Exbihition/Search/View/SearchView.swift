//
//  SearchView.swift
//  National_Exbihition
//
//  Created by ly on 2017/11/21.
//  Copyright © 2017年 shikeTeam. All rights reserved.
//

import UIKit


protocol searchviewDelegate {
    func getDatabase() -> searchDatabase
}


class SearchView: UIView {
    
    
    var tableview:UITableView!
    var database:searchviewDelegate?
    var flag = true;//true 为搜索历史
    let btn = UIButton.init(frame: FloatRect(0, 0, SCREEN_WIDTH, getHeight(95)))    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setTV()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTV(){
        self.tableview = UITableView(frame:self.frame)
        self.tableview.delegate = self
        self.tableview.dataSource = self
        self.addSubview(tableview)
    }
    
    func saveInfo(index:Int){
        //      if let exit = UserDefaults.standard.dictionary(forKey: "history")
        let usd = UserDefaults.standard;
        print(database?.getDatabase().resultTag);
  usd.set([database?.getDatabase().resultTag[index],database?.getDatabase().resultName[index]], forKey: "history");
        print(usd.array(forKey: "history"))
    }
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

extension SearchView:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if flag{
            if let data = Int((database?.getDatabase().historyNames[0]?[0])!){
           // print(data)
             return data
          }else{
             return 0
          }
        }else{
            if let data = database?.getDatabase().resultName.count{
                // print(data)
                return data
            }else{
                return 0
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        var num:Int = 0;
        if let c = database?.getDatabase().historyNames[indexPath.row+1]?.count{
            num = c-1
        }
    
        if flag{
            let cell = SearchHistoryTableViewCell.init(style: .default, reuseIdentifier: "cell",count:num)
           if let data = database?.getDatabase().historyNames[indexPath.row+1]{
            for i in  0...data.count-1{
                cell.labels[i].setTitle(data[i], for: .normal)
            }
            
            
            }
            return cell
            
        }else{
            let cell = TabTableViewCell.init(style: .default, reuseIdentifier: "cell")
            if let data = database?.getDatabase().resultName[indexPath.row]{
                cell.flagImage.sd_setImage(with: getImage(fg:  (database?.getDatabase().resultImage[indexPath.row])!))
                cell.nameTitle.text = data
                cell.contentLabel.text = database?.getDatabase().resultDetail[indexPath.row]
                
                cell.nameTitle.sizeToFit()
                //cell.contentLabel.text = " "
            }
            
            
            return cell
        }

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if flag{
            return 2
        }else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if flag{
        if section == 0{
            return "搜索历史"
        }else{
            return "热门搜索"
        }
        }else{
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if !flag{
            return getHeight(135)
        }
        return getHeight(95)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if !flag{
            let view = UIView.init(frame: FloatRect(0, 0, SCREEN_WIDTH, getHeight(95)))
            
            view.backgroundColor = backColor
           
            btn.setTitle("类别", for: .normal)
            btn.setTitleColor(title1Color, for: .normal)
            view.addSubview(btn)
            return view
        }
        
        return nil
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.saveInfo(index: indexPath.row)
        tableView.cellForRow(at: indexPath)?.isSelected = false
    }
    
    

}
