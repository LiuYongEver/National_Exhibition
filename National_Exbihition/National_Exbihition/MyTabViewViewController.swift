//
//  MyTabViewViewController.swift
//  National_Exbihition
//
//  Created by 刘勇 on 2018/5/8.
//  Copyright © 2018年 shikeTeam. All rights reserved.
//

import UIKit

class MyTabViewViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        CusTomTabBar();
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func CusTomTabBar(){
        let vc1 = IndexViewController()
        let vc2 = ChartViewController()
        let vc3 = CommunityViewController()
        let vc4 = MineViewController()
        // let vc5 = IndexViewController()
        
        
        let nvc1:UINavigationController = UINavigationController(rootViewController: vc1)
        let nvc2:UINavigationController = UINavigationController(rootViewController: vc2)
        let nvc3:UINavigationController = UINavigationController(rootViewController: vc3)
        let nvc4:UINavigationController = UINavigationController(rootViewController: vc4)
        //let nvc5:UINavigationController = UINavigationController(rootViewController:vc5)
        
        let tabbar1 = UITabBarItem(title: "首页", image: UIImage(named:"bottom1"), selectedImage:  UIImage(named:"bottom1"))
        // tabbar1.imageInsets = UIEdgeInsetsMake(getHeight(25), width(25), getHeight(25), width(25))
        let tabbar2 = UITabBarItem(title: "文献数据", image: UIImage(named:"bottom2"), selectedImage:  UIImage(named:"bottom2"))
        let tabbar3 = UITabBarItem(title: "社区",image: UIImage(named:"bottom3"), selectedImage:  UIImage(named:"bottom3"))
        let tabbar4 = UITabBarItem(title: "我的", image: UIImage(named:"bottom4"), selectedImage:  UIImage(named:"bottom4"))
        nvc1.tabBarItem = tabbar1;
        nvc2.tabBarItem = tabbar2;
        nvc3.tabBarItem = tabbar3;
        nvc4.tabBarItem = tabbar4;
        self.tabBar.tintColor = naviColor
        self.viewControllers = [nvc1,nvc2,nvc3,nvc4]
        // tc.tabBar.backgroundImage = Public.getImgView("3.png")tc.viewControllers = [nvc1,nvc2,nvc3,nvc4,nvc5];return tc;
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
