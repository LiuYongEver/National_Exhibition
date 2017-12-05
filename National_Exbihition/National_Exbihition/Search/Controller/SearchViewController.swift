//
//  SearchViewController.swift
//  National_Exbihition
//
//  Created by ly on 2017/11/18.
//  Copyright © 2017年 shikeTeam. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    var searchBar:UISearchBar!
    var searchData:searchDatabase?
    var searchContentView:SearchView!
    override func viewDidLoad() {
        netRequest()
        setNaviView()

        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool){
        self.searchBar.removeFromSuperview()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        
        self.searchContentView = SearchView.init(frame: self.view.frame)
        self.searchContentView.database = self
        self.view.addSubview(searchContentView)

    }
    
    func netRequest(){
        self.searchData = searchDatabase(historyNames:[
            0:["2"],
            1:["1","sa","swq","asdqewf"],2:["2","3"]],historyTags:[1:["1","sa","swq","asdqewf","afeqwas"]] ,hotName:["1"], hotTag:["1"],resultName:["2"],resultTag:["s"])
        print(Int((searchData?.historyNames[0]![0])!))
        
        
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
extension SearchViewController:UISearchBarDelegate,searchviewDelegate{
    
    func getDatabase() -> searchDatabase {
        return self.searchData!
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != ""{
            searchContentView.flag = false
            self.searchData?.resultName.append(searchText)
            self.searchContentView.tableview.reloadData()
        }else{
            searchContentView.flag = true
            self.searchContentView.tableview.reloadData()
        }
    }
    
    
}
