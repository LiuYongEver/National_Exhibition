//
//  ChartViewController.swift
//  National_Exbihition
//
//  Created by ly on 2017/11/16.
//  Copyright © 2017年 shikeTeam. All rights reserved.
//

import UIKit
import Charts
import Alamofire
class ChartViewController: UIViewController{
    
    let searchBar = UISearchBar()
    let ImageExbihition = UIImageView()
    var chartView:ChartView!
    var DataBase:[ChartData_Populaton]?{
        didSet{
            self.chartView.dataBase = DataBase
            setChart()
            
        }
        
        
    }
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavi()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = backColor;
        loadData()
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
        
        
        let   totalButton = UIButton(frame:Rect(47, 800, 658, 88))
        totalButton.backgroundColor = naviColor
        totalButton.layer.cornerRadius = 5
        totalButton.layer.masksToBounds = true
        totalButton.setTitleColor(UIColor.white, for: .normal)
        totalButton.setTitle("更多国家", for: .normal)
        self.chartView.addSubview(totalButton)
        totalButton.addTarget(self, action: #selector(pushMore), for: .touchUpInside);
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
        let btn = UIButton(frame:FloatRect(0, 0, getWidth(509), getHeight(100)))
        btn.backgroundColor = UIColor.clear
        searchBar.addSubview(btn)
        btn.addTarget(self, action: #selector(searchTouch), for: .touchUpInside)
        self.navigationController?.navigationBar.addSubview(searchBar)

        ImageExbihition.frame = Rect(26,21, 155, 41)
        ImageExbihition.image = #imageLiteral(resourceName: "国情概览"); self.navigationController?.navigationBar.addSubview(ImageExbihition)
    }
    
    func  setPageView(){
        var childVcs = [UIViewController]()
        let title  =  ["统计数据","重要研究","其他文献"]
        for i in 0...title.count-1{
            childVcs.append(UIViewController())
            childVcs[i].view.backgroundColor = backColor
        }
        
        let wenxian = TabTableViewController.init(index: "重要文献")

        chartView.backgroundColor = backColor
        childVcs[0].view.addSubview(chartView)
        childVcs[2] = wenxian
        let vieww = IndexPageView(frame: FloatRect(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64),titles: title,child:childVcs,parentViewController: self)
        self.view.addSubview(vieww)

    }
    
    @objc func pushMore(){
        self.ImageExbihition.removeFromSuperview();
        self.searchBar.removeFromSuperview();
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"",style:.plain,target:nil,action:nil);
        self.navigationController?.pushViewController(MoreChartViewController(), animated: true)
    }
    
    @objc func searchTouch(){
        self.ImageExbihition.removeFromSuperview()
        self.searchBar.removeFromSuperview()
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"",style:.plain,target:nil,action:nil);
        self.navigationController?.pushViewController(SearchViewController(), animated: true)
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
    
    
    func loadData(){
        
        let url = rootUrl+"/findInternationaleDataByContinent"
        let param = ["continent":"亚洲","kind":"9","year":"2015","end_year":"2017"]
        
        AlaRequestManager.shared.POST(urlString: url, params: param as [String : AnyObject], success:({
            json in
           // print(json)
            //let js = JSON(json).dictionaryObject
           // print(js!["data"] as! [String:AnyObject])
            // let dic = "\u{2665}";
            //  print(dic.unicodeScalars)
            //print(json["data"] as Any)
            
            if let lists = json["data"]!["Population"] as? [[String:AnyObject]]{
                //print(lists)
                //let dic = [["id":2,"focusing_nickname":"1","focusingPicture":"1"]]
                let models = ChartData_Populaton.dictToModel(list:lists as [[String : AnyObject]])
                self.DataBase = models
               // print(models[0].nation_z)
               // self.funs = models
                
            }
            

     
            
        }))

        
    }
    
    
    
}
