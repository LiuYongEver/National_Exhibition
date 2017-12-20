//
//  AppDelegate.swift
//  National_Exbihition
//
//  Created by ly on 2017/11/8.
//  Copyright © 2017年 shikeTeam. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,BMKGeneralDelegate{

    var window: UIWindow?
    var _mapManager:BMKMapManager?
    func setMap(){
        _mapManager = BMKMapManager()
        /**
         *百度地图SDK所有接口均支持百度坐标（BD09）和国测局坐标（GCJ02），用此方法设置您使用的坐标类型.
         *默认是BD09（BMK_COORDTYPE_BD09LL）坐标.
         *如果需要使用GCJ02坐标，需要设置CoordinateType为：BMK_COORDTYPE_COMMON.
         */
        if BMKMapManager.setCoordinateTypeUsedInBaiduMapSDK(BMK_COORDTYPE_BD09LL) {
            NSLog("经纬度类型设置成功");
        } else {
            NSLog("经纬度类型设置失败");
        }
        
        // 如果要关注网络及授权验证事件，请设定generalDelegate参数
        let ret = _mapManager?.start("u6aBLlEWt4ppufVcjAIDAn8k2HgZAviK", generalDelegate: self)
        if ret == false {
            NSLog("manager start failed!")
            return
        }
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame:UIScreen.main.bounds)
       // window?.rootViewController = UINavigationController(rootViewController:IndexViewController())
        window?.rootViewController = self.CusTomTabBar()
        self.window?.backgroundColor = naviColor
        window?.makeKeyAndVisible()
        //window?.backgroundColor = UIColor.white
        let navBar=UINavigationBar.appearance()
        //.设置导航栏标题颜色
        navBar.titleTextAttributes = [ NSAttributedStringKey.foregroundColor : UIColor.white]
        //navBar.backItem?.backBarButtonItem = UIBarButtonItem(title:"",style:.plain,target:nil,action:nil)
        //.设置导航栏按钮颜色
     //navBar.tintColor = UIColor.white
        //.设置导航栏背景颜色
        //.状态栏文字白色风格
       // UIApplication.shared.statusBarStyle = .lightContent
        setMap()
        
        
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func CusTomTabBar() ->UITabBarController{
        let vc1 = IndexViewController()
        let vc2 = ChartViewController()
        let vc3 = IndexViewController()
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
        let tabbar3 = UITabBarItem(title: "学习解惑",image: UIImage(named:"bottom3"), selectedImage:  UIImage(named:"bottom3"))
        let tabbar4 = UITabBarItem(title: "我的", image: UIImage(named:"bottom4"), selectedImage:  UIImage(named:"bottom4"))
        nvc1.tabBarItem = tabbar1;
        nvc2.tabBarItem = tabbar2;
        nvc3.tabBarItem = tabbar3;
        nvc4.tabBarItem = tabbar4;
        let tc = UITabBarController()
        tc.tabBar.tintColor = naviColor
        tc.viewControllers = [nvc1,nvc2,nvc4]
        // tc.tabBar.backgroundImage = Public.getImgView("3.png")tc.viewControllers = [nvc1,nvc2,nvc3,nvc4,nvc5];return tc;
        return tc
    }

    //MARK: - BMKGeneralDelegate
    func onGetNetworkState(_ iError: Int32) {
        if (0 == iError) {
            NSLog("联网成功");
        }
        else{
            NSLog("联网失败，错误代码：Error\(iError)");
        }
    }
    
    func onGetPermissionState(_ iError: Int32) {
        if (0 == iError) {
            NSLog("授权成功");
        }
        else{
            NSLog("授权失败，错误代码：Error\(iError)");
        }
    }
    


}

