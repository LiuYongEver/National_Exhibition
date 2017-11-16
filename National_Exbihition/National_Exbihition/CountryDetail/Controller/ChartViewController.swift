//
//  ChartViewController.swift
//  National_Exbihition
//
//  Created by ly on 2017/11/16.
//  Copyright © 2017年 shikeTeam. All rights reserved.
//

import UIKit
import Charts
class ChartViewController: UIViewController{
    
    let searchBar = UISearchBar()
    var chartView:ChartView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavi()
        setChart()
        setPageView()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setChart(){
        chartView = ChartView.init(frame: self.view.frame)
        chartView.backgroundColor = backColor
         //self.view.addSubview(chartView)
    }
    
    // MARK: - Navigation
     func setNavi(){
        self.navigationController?.navigationBar.barTintColor = naviColor
        self.navigationController?.navigationBar.isTranslucent = false
        self.searchBar.delegate = self
        searchBar.frame = Rect(205, 20, 509, 42)
        searchBar.tintColor = naviColor
        searchBar.placeholder = "中国"
        searchBar.layer.cornerRadius = 5
        // searchBar.backgroundColor = UIColor.white
        //searchBar.layer.masksToBounds = true
        self.navigationController?.navigationBar.addSubview(searchBar)
        let ImageExbihition = UIImageView()
        ImageExbihition.frame = Rect(26,21, 155, 41)
        ImageExbihition.image = #imageLiteral(resourceName: "国家展示"); self.navigationController?.navigationBar.addSubview(ImageExbihition)
    }
    
    func  setPageView(){
        var childVcs = [UIViewController]()
        childVcs.append(UIViewController())
        let title  =  ["统计数据","重要文献","重要研究"]
        for i in 1...title.count-1{
            childVcs.append(TabTableViewController(index:title[i]))
        }
        
        childVcs[0].view.addSubview(chartView)
        
        let vieww = IndexPageView(frame: FloatRect(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64),titles: title,child:childVcs,parentViewController: self)
        self.view.addSubview(vieww)
    }
    
    
/*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ChartViewController:UISearchBarDelegate{
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("开始搜索")
    }
    
}
