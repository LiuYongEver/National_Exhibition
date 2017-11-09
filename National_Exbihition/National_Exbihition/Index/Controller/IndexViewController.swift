//
//  IndexViewController.swift
//  National_Exbihition
//
//  Created by ly on 2017/11/8.
//  Copyright © 2017年 shikeTeam. All rights reserved.
//

import UIKit

class IndexViewController: UIViewController {
    let searchBar = UISearchBar()
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
        for _ in 0..<5 {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(red: CGFloat(arc4random_uniform(255))/255.0, green: CGFloat(arc4random_uniform(255))/255.0, blue: CGFloat(arc4random_uniform(255))/255.0, alpha: 1.0)
            childVcs.append(vc)
        }
        childVcs[0] = RecommendViewController()
        childVcs[1] = BasicInformationViewController()
        
        let title  =  ["推荐","基本信息","环境资源","政治军事","经济发展"]
        let vieww = IndexPageView(frame: FloatRect(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64),titles: title,child:childVcs,parentViewController: self)
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

extension IndexViewController:UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
    
}
