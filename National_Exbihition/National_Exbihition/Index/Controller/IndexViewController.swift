//
//  IndexViewController.swift
//  National_Exbihition
//
//  Created by ly on 2017/11/8.
//  Copyright © 2017年 shikeTeam. All rights reserved.
//

import UIKit


protocol resignDelegate:class {
    func resign()
}



class IndexViewController: UIViewController{
    let searchBar = UISearchBar()
    let delegate : resignDelegate? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNaviView()
       // self.navigationController?.navigationBar.isHidden = true
        setPageView()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  
    public func resignSearch(){
        
        self.searchBar.resignFirstResponder()
    }
    
    
    
    func setNaviView(){
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
  
        childVcs.append(RecommendViewController())
     
        
        let title  =  ["推荐","基本信息","环境资源","政治军事","经济发展","社会状况","科技教育","国际关系","侨情","国际数据"]
        for i in 1...title.count-1{
            childVcs.append(TabTableViewController(index:title[i]))
        }
        
        let vieww = IndexPageView(frame: FloatRect(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64),titles: title,child:childVcs,parentViewController: self)
        vieww.delegate = self
        self.view.addSubview(vieww)
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

extension IndexViewController:UISearchBarDelegate,resignDelegate{
    
    
    func resign() {
        self.searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
    
}
