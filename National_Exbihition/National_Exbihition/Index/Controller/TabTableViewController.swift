//
//  TabTableViewController.swift
//  National_Exbihition
//
//  Created by ly on 2017/11/10.
//  Copyright © 2017年 shikeTeam. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage
import SVProgressHUD
import SwiftFCXRefresh

protocol selectContinetDelegate {
    func getContinent(str:String)
}


class TabTableViewController: UIViewController{
    
    public var dataBase:[String:[String]] = [
        "flag":[],
        "name":[],
        "nation_id":[],
        "capital":[],
        "establish_time":[]
    ]
    
    var index : String?
    var getContinet = ""
    var footerRefreshView:FCXRefreshFooterView?
    fileprivate var tableview:UITableView?
    var page = 0
    
    lazy var changeLocation:UIButton = {
        let button = UIButton(frame:FloatRect(0, 0, SCREEN_WIDTH, getHeight(47)))
        button.setTitle("现在在亚洲，点击选择其他大洲", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: getHeight(26))
        button.setTitleColor(title2color, for: .normal)
        button.layer.borderWidth = getHeight(1)
        button.layer.borderColor = lineColor.cgColor
        button.backgroundColor = backColor
        button.addTarget(self, action: #selector(selectTouch), for: .touchUpInside)
        return button
        
    }()
    
    

    
    init(index:String) {
        super.init(nibName: nil, bundle: nil)
        self.index = index
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

    override func viewDidLoad() {
        
        self.view.backgroundColor = UIColor.white
        request()
        setTV()
        addRefreshView()
        super.viewDidLoad()


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func addRefreshView() {
        footerRefreshView =
            tableview?.addFCXRefreshFooter { [weak self] (refreshHeader) in
                self?.loadMoreAction()
        }
    }
    func loadMoreAction() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) { [weak self] in
            guard let weakSelf = self,
                let footerRefreshView = self?.footerRefreshView else {
                    return
            }
            weakSelf.page+=1
            weakSelf.request()
            // weakSelf.rows += 20
            // self?.tableview.reloadData()
        }
        
    }
    
    
   // MARK: - Alarequest
    
    func request(){
        SVProgressHUD.show(withStatus:"loading")
        var continent_id = "A"
        var titles = ["亚洲 (Asia)","欧洲 (Europe)","北美洲 (North America)","南美洲 (South America)","非洲 (Africa)","大洋洲 (Oceania)","南极洲 (Antarctica)" ]
        
        switch getContinet{
        case titles[0]:
            continent_id = "A"
        case titles[1]:
            continent_id = "B"
        case titles[2]:
            continent_id = "C"
        case titles[3]:
            continent_id = "D"
        case titles[4]:
            continent_id = "E"
        case titles[5]:
            continent_id = "F"
        case titles[6]:
            continent_id = "G"
        default:
            break
        }
        print(getContinet,continent_id)

        let url = rootUrl+"/firstpage_find_"+getIndex().Index
        let parameter = ["page":"\(self.page)","continent_id":continent_id]
        Alamofire.request(url, method: .post,parameters:parameter).responseJSON(completionHandler: {
            response in
            if let al = response.response{
                // print(al)
            }else{
                SVProgressHUD.showError(withStatus: "网络连接失败")
                SVProgressHUD.dismiss(withDelay: 1)
            }
            
            if let js = response.result.value{
                let json = JSON(js)
                print(json)
                if  json["data"].count-1>0{
                    for i in 0...json["data"].count-1{
                        self.dataBase["name"]?.append(json["data"][i]["nation_z"].string!)
                        if let flag = json["data"][i]["nation_flag"].string{
                            self.dataBase["flag"]?.append(flag)
                        }else{
                            self.dataBase["flag"]?.append("");
                        }
                        if let flag = json["data"][i]["establish_time"].string{
                            self.dataBase["establish_time"]?.append(flag)
                        }else{
                            self.dataBase["establish_time"]?.append("")
                        }
                        if let flag = json["data"][i]["capital"].string{
                            self.dataBase["capital"]?.append(flag)
                        }else{
                            self.dataBase["capital"]?.append("")
                        }
                        self.dataBase["nation_id"]?.append(json["data"][i]["country_code"].string!)
                        
                        
                        //self.dataBase["content"]?.append("")
                        //self.dataBase["name"]![i]+self.dataBase["establish_time"]![i]+self.dataBase["capital"]![i]
                    }
                   // print(self.dataBase)
                    self.footerRefreshView?.endRefresh()
                    SVProgressHUD.dismiss()
                    self.tableview?.reloadData()
                }else{
                    self.footerRefreshView?.showNoMoreData()
                }
                
                
            }
            
        })
        
        SVProgressHUD.dismiss()
         
        
        
        
        
//        for i in 0...5{
//        self.dataBase["flag"]?.append("ss")
//        self.dataBase["name"]?.append("中国")
//        self.dataBase["content"]?.append("国名   中国，是大手笔方法好欺负那可是粉红 i 企鹅放假啊反馈客户问起恢复 i 恶气本菲卡是毕福剑阿富汗 i 前后放假啊什么能发掘并发放 i 啊师傅把沙发")
//        }
    }
    
    
    
    
    
    
    func setTV(){
        self.tableview = UITableView(frame:FloatRect(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-99-54))
        tableview?.delegate = self
        tableview?.dataSource = self
        self.view.addSubview(tableview!)
        
        
    }
    
    
    @objc func selectTouch(){
        let animation = CATransition.init()
        animation.type = kCATransitionFade
        animation.subtype = kCATransitionFromRight
        animation.duration = 0.5
        self.view.window?.layer.add(animation, forKey: nil)
        
        let vc = SelectContinentTableViewController()
        vc.delegate = self
        //self.changeLocation.setTitle("您已选择: "+getContinet!,for: .normal)
        let nav = UINavigationController.init(rootViewController: vc)
        self.present(nav, animated: false, completion: nil)

        
        
    }
    
    func clearDatabase(){
        for i in dataBase.keys{
            dataBase[i]?.removeAll()
        }
        
    }
    
    func getIndex()->(Index:String,IndexCode:Int){
        let indexx = ["","nationinfo","nature","politic","development","society","technology","relationship","overseas",""]
         let ttitle  =  ["推荐","基本信息","环境资源","政治军事","经济发展","社会状况","科技教育","国际关系","侨情","国际数据"]
        for i in 0...ttitle.count-1{
            if ttitle[i] == index{
                return (indexx[i],i)
            }
            
        }
        return ("",0)
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


extension TabTableViewController:UITableViewDelegate,UITableViewDataSource,selectContinetDelegate
{
    
    func getContinent(str: String) {
        self.changeLocation.setTitle("您已选择: "+str,for: .normal)
        self.getContinet = str
        self.clearDatabase()
        self.request()
        self.tableview?.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.dataBase["name"]?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TabTableViewCell(style: .default ,reuseIdentifier:"cell")
       
        
        let fg = dataBase["flag"]?[indexPath.row]
        if  fg != "" {
            cell.flagImage.sd_setImage(with: URL.init(string: fg!), completed: nil)
        }else{
            cell.flagImage.image = #imageLiteral(resourceName: "baccc")
        }
        
        cell.nameTitle.text = (self.dataBase["name"]?[indexPath.row])! + "   \(self.index!)"
        cell.nameTitle.sizeToFit()
        let content = ("国名： "+self.dataBase["name"]![indexPath.row]+" 建立时间:"+self.dataBase["establish_time"]![indexPath.row]+" 首都："+self.dataBase["capital"]![indexPath.row])
        cell.contentLabel.text = (content)//+self.dataBase["capital"]![indexPath.row])
        //cell.contentLabel.sizeToFit()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return getHeight(135)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return getHeight(47)
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return changeLocation
    
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.isSelected = false
        
        for i in (self.navigationController?.navigationBar.subviews)!{
            i.removeFromSuperview()
        }
       
        let vc = BasicInformationViewController(title:(self.dataBase["nation_id"]?[indexPath.row])!,defaultCode:(getIndex().IndexCode-1))
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
        vc.hidesBottomBarWhenPushed = false

//        let nav = UINavigationController(rootViewController:BasicInformationViewController(title:(self.dataBase["nation_id"]?[indexPath.row])!,defaultCode:(getIndex().IndexCode-1)))
//        let animation = CATransition.init()
//        animation.duration = 0.5;
//        animation.type = kCATransitionFade
//        animation.subtype = kCATransitionFromRight
        //self.view.window?.layer.add(animation, forKey: nil)
       
       // self.present(nav, animated: false, completion: nil)
        
    }

    
    
}
