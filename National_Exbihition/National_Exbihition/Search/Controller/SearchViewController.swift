//
//  SearchViewController.swift
//  National_Exbihition
//
//  Created by ly on 2017/11/18.
//  Copyright © 2017年 shikeTeam. All rights reserved.
//

import UIKit
import  Alamofire

class SearchViewController: UIViewController,UINavigationControllerDelegate{

    var searchBar:UISearchBar!
    var searchData:searchDatabase?
    var searchContentView:SearchView!
    var searchString = ""
    var type:String?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setNaviView()
        self.searchBar.isHidden = false
        self.searchBar.text = self.searchString
        
    }
    override func viewDidLoad() {
        netRequest()
       
        super.viewDidLoad()
        self.searchContentView = SearchView.init(frame: self.view.frame)
        self.searchContentView.database = self
        self.view.addSubview(searchContentView)
        searchContentView.btn.addTarget(self, action: #selector(pushVc), for: .touchUpInside)

        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool){
        self.searchBar.isHidden = true
        self.searchBar.resignFirstResponder()
    }
    
 
 

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @objc func pushVc(){
        let vc  = SelectTypeTableViewController()
          vc.delegate = self
        let Nvc = UINavigationController.init(rootViewController:vc )
       self.searchBar.isHidden = false
        self.present(Nvc, animated: true, completion: nil)
        
    }
    
    func setNaviView(){
        self.navigationController?.navigationBar.barTintColor = naviColor
        self.navigationController?.navigationBar.isTranslucent = false
        searchBar = UISearchBar()
        self.searchBar.delegate = self
        searchBar.frame = Rect(105, 30, 609, 42)
        searchBar.tintColor = naviColor
        searchBar.placeholder = "中国"
        searchBar.layer.cornerRadius = 5
        // searchBar.backgroundColor = UIColor.white
        //searchBar.layer.masksToBounds = true
        self.navigationController?.navigationBar.addSubview(searchBar)
        
      
        

    }
    
    func netRequest(){
        
        
        let usd = UserDefaults.standard
        let ary =  usd.array(forKey: "history") as! [String]
        
        self.searchData = searchDatabase(historyNames:[
            0:["2"],
            1:ary],historyTags:[1:ary] ,hotName:["中国"], hotTag:["1"],resultName:[],resultTag:[],resultDetail:[],resultImage:[])
        //print(Int((searchData?.historyNames[0]![0])!))
        
        
    }
    
    
    func removeResult(){
        self.searchData?.resultName.removeAll()
        self.searchData?.resultDetail.removeAll()
        self.searchData?.resultTag.removeAll()
    }
    
    
    func alaRequest(){
        
        
        
        self.removeResult()
        let url = rootUrl+"/searchByCountryName"
        // print(country_code)
        let paramete = ["country_name":"\(self.searchString)"]
        // print(paramete)
        Alamofire.request(url, method: .post,parameters:paramete).responseJSON(completionHandler: {
            response in
            if let al = response.response{
                // print(al)
                // print(response.result.isSuccess)
            }else{
                
            }
            
            if let js = response.result.value{
                let json = JSON(js)//["data"]
                print(json)
                
                if  json["data"]["NationInfo"].exists(){
                    if let gg = json["data"]["NationInfo"]["nation_z"].string{
                        self.searchData?.resultName.append(gg+"基本信息")
                    }
                }
                if let gg2 = json["data"]["NationInfo"]["country_code"].string{
                    self.searchData?.resultTag.append(gg2)
                }else{
                    self.searchData?.resultTag.append("")
                }
                
                
                
                
                if self.type == "环境资源" {
                if  json["data"]["Nature"].exists(){
                    if let gg = json["data"]["Nature"]["nation_z"].string{
                        self.searchData?.resultName.append(gg+"  自然资源")
                        if let gg2 = json["data"]["Nature"]["geography"].string{
                             self.searchData?.resultDetail.append(gg2)
                        }else{
                             self.searchData?.resultDetail.append("")
                        }
                        if let gg2 = json["data"]["Nature"]["nation_flag"].string{
                            self.searchData?.resultImage.append(gg2)
                        }else{
                            self.searchData?.resultImage.append("")
                        }
                        
                        if let gg2 = json["data"]["Nature"]["country_code"].string{
                            self.searchData?.resultTag.append(gg2)
                        }else{
                            self.searchData?.resultTag.append("")
                        }
                        
                        
                        
                    }
                }
                }
                
                
                if self.type == "政治军事" {
                    if  json["data"]["Politic"].exists(){
                        if let gg = json["data"]["Politic"]["nation_z"].string{
                            self.searchData?.resultName.append(gg+"  政治军事")
                            if let gg2 = json["data"]["Politic"]["constitution"].string{
                                self.searchData?.resultDetail.append(gg2)
                            }else{
                                self.searchData?.resultDetail.append("")
                            }
                            if let gg2 = json["data"]["Politic"]["nation_flag"].string{
                                self.searchData?.resultImage.append(gg2)
                            }else{
                                self.searchData?.resultImage.append("")
                            }
                            
                            if let gg2 = json["data"]["Politic"]["country_code"].string{
                                self.searchData?.resultTag.append(gg2)
                            }else{
                                self.searchData?.resultTag.append("")
                            }
                            
                        }
                    }
                }
                
                
                if self.type == "经济发展" {
                    if  json["data"]["Development"].exists(){
                        if let gg = json["data"]["Development"]["nation_z"].string{
                            self.searchData?.resultName.append(gg+"  经济发展")
                            if let gg2 = json["data"]["Development"]["economy"].string{
                                self.searchData?.resultDetail.append(gg2)
                            }else{
                                self.searchData?.resultDetail.append("")
                            }
                            if let gg2 = json["data"]["Development"]["nation_flag"].string{
                                self.searchData?.resultImage.append(gg2)
                            }else{
                                self.searchData?.resultImage.append("")
                            }
                            
                            
                            if let gg2 = json["data"]["Development"]["country_code"].string{
                                self.searchData?.resultTag.append(gg2)
                            }else{
                                self.searchData?.resultTag.append("")
                            }
                        }
                    }
                }
                
                
                
                
                self.searchContentView.tableview.reloadData()
               
                if self.type != nil{
                     print(self.type)
                    DispatchQueue.main.async {
                    self.searchContentView.btn.setTitle("已选择"+self.type!, for: .normal);
                    }
                }
            }
        })
        
        
        
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
extension SearchViewController:UISearchBarDelegate,searchviewDelegate,selectContinetDelegate{
    
    
    func getContinent(str: String) {
        self.type = str
        self.searchContentView.btn.setTitle("已选择"+str, for: .normal)
        alaRequest()
    }
    
    func getDatabase() -> searchDatabase {
        return self.searchData!
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != ""{
            searchContentView.flag = false
            self.searchString = searchText
          //alaRequest()
            //self.searchData?.resultName.append(searchText)
           // self.searchContentView.tableview.reloadData()
        }else{
            searchContentView.flag = true
            self.searchContentView.tableview.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        alaRequest()
    }
    
    
}
