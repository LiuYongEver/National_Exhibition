//
//  AllCountryViewController.swift
//  National_Exbihition
//
//  Created by ly on 2017/11/28.
//  Copyright © 2017年 shikeTeam. All rights reserved.
//

import UIKit

class AllCountryViewController: UIViewController {var userArray: [Userr] = [Userr]()
    var sectionsArray: [[Userr]] = [[Userr]]()
    var indexArray: [String] = [String]()
    
    var searchBar = UISearchBar()
    
    
    // uitableView 索引搜索工具类
    var collation: UILocalizedIndexedCollation? = nil
    
    override func viewDidLoad() {
        setNaviView()
        super.viewDidLoad()
        var tableView = UITableView.init(frame: self.view.frame)
        tableView.backgroundColor = backColor
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        self.configureSection()
    }
    
    
    func setNaviView(){
        self.navigationController?.navigationBar.barTintColor = naviColor
        self.navigationController?.navigationBar.isTranslucent = false
        
        let backbutton = UIButton(type: .custom)
        backbutton.frame = CGRect(x: 0, y: 0, width:68, height: 60)
        //backbutton.setImage(UIImage(named: "back@1x"), for: .normal)
        let bti = UIImageView.init(frame:( CGRect(x:0, y: 13, width: 22, height: 22)))
        bti.image = #imageLiteral(resourceName: "back@1x")
        backbutton.addSubview(bti)
        backbutton.addTarget(self, action: #selector(touchReturn), for: .touchUpInside)
        let item = UIBarButtonItem(customView: backbutton)
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        barButtonItem.width = -5
        //item.tintColor = UIColor.white
        self.navigationItem.leftBarButtonItems = [barButtonItem,item]
        self.navigationItem.title = "全部国家"
        let dict:NSDictionary = [NSAttributedStringKey.foregroundColor: UIColor.white,NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 18)]
        //标题颜色
        self.navigationController?.navigationBar.titleTextAttributes = dict as? [NSAttributedStringKey : Any]
        
        searchBar.frame = Rect(90, 30, 609, 42)
        searchBar.tintColor = naviColor
        searchBar.placeholder = "中国"
        searchBar.layer.cornerRadius = 5
        
        let btn = UIButton(frame:FloatRect(0, 0, getWidth(509), getHeight(92)))
        btn.backgroundColor = UIColor.clear
        searchBar.addSubview(btn)
        btn.addTarget(self, action: #selector(searchTouch), for: .touchUpInside)
        // searchBar.backgroundColor = UIColor.white
        //searchBar.layer.masksToBounds = true
        self.navigationController?.navigationBar.addSubview(searchBar)
        
        
    }
    @objc func touchReturn(){
        self.dismiss(animated: false, completion: nil)
    }
    @objc func searchTouch(){}
    
    
    //MARK: - 设置section
    func configureSection() {
        for i in 0...3 {
            userArray.append(Userr(name: "中国\(i)"))
            userArray.append(Userr(name: "美国\(i)"))
            userArray.append(Userr(name: "苏联\(i)"))

        }
        userArray.append(Userr(name: "咯理"))
        

        //获得当前UILocalizedIndexedCollation对象并且引用赋给collation,A-Z的数据
        collation = UILocalizedIndexedCollation.current()
        //获得索引数和section标题数
        let sectionTitlesCount = collation!.sectionTitles.count
        
        //临时数据，存放section对应的userObjs数组数据
        var newSectionsArray = [[Userr]]()
        
        //设置sections数组初始化：元素包含userObjs数据的空数据
        for _ in 0..<sectionTitlesCount {
            let array = [Userr]()
            newSectionsArray.append(array)
        }
        
        //将用户数据进行分类，存储到对应的sesion数组中
        
        for bean in userArray {
            //根据timezone的localename，获得对应的的section number
            let sectionNumber = collation?.section(for: bean, collationStringSelector: #selector( getter: Userr.name))
            //获得section的数组
            var sectionBeans = newSectionsArray[sectionNumber!]
            
            //添加内容到section中
            sectionBeans.append(bean)
            
            // swift 数组是值类型，要重新赋值
            newSectionsArray[sectionNumber!] = sectionBeans
        }
        
        
        //排序，对每个已经分类的数组中的数据进行排序，如果仅仅只是分类的话可以不用这步
        for i in 0..<sectionTitlesCount {
            let beansArrayForSection = newSectionsArray[i]
            //获得排序结果
            let sortedBeansArrayForSection = collation?.sortedArray(from: beansArrayForSection, collationStringSelector:  #selector(getter: Userr.name))
            //替换原来数组
            newSectionsArray[i] = sortedBeansArrayForSection as! [Userr]
            
        }
        
        sectionsArray = newSectionsArray
    }
}

// MARK: - tableviewDelegate
extension AllCountryViewController:UITableViewDataSource,UITableViewDelegate{
    
     func numberOfSections(in tableView: UITableView) -> Int {
        return (collation?.sectionTitles.count)!
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let beanInSection = sectionsArray[section]
        return beanInSection.count
    }
    
    //设置每行的cell的内容
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let id = "id"
        var cell = tableView.dequeueReusableCell(withIdentifier: id)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: id)
        }
        let userNameInSection = sectionsArray[indexPath.section]
        let bean = userNameInSection[indexPath.row]
        cell?.textLabel?.text = (bean as AnyObject).name
        return cell!
    }
    
    /*
     * 跟section有关的设定
     */
    //设置section的Header
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let beansInSection = sectionsArray[section]
        if (beansInSection as AnyObject).count <= 0 {
            return nil
        }
        if let headserString = collation?.sectionTitles[section] {
            if !indexArray.contains(headserString) {
                indexArray.append(headserString)
            }
            return headserString
        }
        return nil
    }
    
    //设置索引标题
     func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        //        return collation?.sectionTitles
        return indexArray
    }
    
    //关联搜索
     func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return (collation?.section(forSectionIndexTitle: index))!
    }
}


class Userr: NSObject{
    @objc var  name: String?
    init(name: String){
        self.name = name
    }
}


