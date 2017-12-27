//
//  RecommendViewController.swift
//  National_Exbihition
//
//  Created by ly on 2017/11/9.
//  Copyright © 2017年 shikeTeam. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD
class RecommendViewController: UIViewController {
    
    let layout = UICollectionViewFlowLayout()
    var collectionView: UICollectionView?
    public var dataBase:[String:[String]] = [
        "flag":[],
        "name":[],
        "nation_id":[],
    ]
 
    
    override func viewDidLoad() {
        request()
        setCollectionView()
        self.view.backgroundColor = backColor
        self.navigationController?.navigationBar.backgroundColor = naviColor
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setCollectionView(){
        layout.itemSize = CGSize(width:getWidth(230),height:getHeight(200))
        layout.minimumInteritemSpacing = getWidth(10)
        layout.minimumLineSpacing = getHeight(30)
        layout.sectionInset = UIEdgeInsetsMake(getHeight(78), getWidth(14), getHeight(407), getWidth(14))
        collectionView = UICollectionView(frame:self.view.frame,collectionViewLayout:layout)
        //self.collectionView?.collectionViewLayout = layout
        //self.collectionView.frame = self.view.frame
        self.collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        self.collectionView?.delegate = self
        self.collectionView?.dataSource = self
        self.collectionView?.backgroundColor = backColor
        self.view.addSubview((collectionView)!)

        
        //头部view
        
        let imagehot = UIImageView(frame:Rect(14, 14, 40, 50))
        imagehot.image = #imageLiteral(resourceName: "热门国家")
        let hotlabel = UILabel(frame:Rect(51, 6, 0,0))
        hotlabel.font = UIFont.systemFont(ofSize: getHeight(32))
        hotlabel.text = "热门国家"
        hotlabel.sizeToFit()
        imagehot.addSubview(hotlabel)
        self.collectionView?.addSubview(imagehot)
        
        let refreshBUtton = UIButton(frame:Rect(636, 12, 110, 40))
        refreshBUtton.setTitle("换一批", for: .normal)
        refreshBUtton.titleLabel?.font = UIFont.systemFont(ofSize: getHeight(26))
        refreshBUtton.setTitleColor(naviColor, for: .normal)
        self.collectionView?.addSubview(refreshBUtton)
        
        let totalButton = UIButton(frame:Rect(47, 800, 658, 88))
        totalButton.backgroundColor = naviColor
        totalButton.layer.cornerRadius = 5
        totalButton.layer.masksToBounds = true
        totalButton.setTitleColor(UIColor.white, for: .normal)
        totalButton.setTitle("全部国家", for: .normal)
        self.collectionView?.addSubview(totalButton)
        totalButton.addTarget(self, action: #selector(allNation), for: .touchUpInside)
        
    
        
    }
    
  @objc  func allNation(){
    
    
    for i in (self.navigationController?.navigationBar.subviews)!{
        i.removeFromSuperview()
    }
        self.navigationController?.pushViewController(AllCountryViewController(), animated: true)
    }
    
    func getImage(fg:String)->URL{
        if  fg != "" {
            let fg2 = fg.components(separatedBy: "webapps/")
            //print(fg2![1])
            let ecc  = imageUrl+fg2[1]
            let eco = ecc.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            let url = URL.init(string:eco!)
            //print(url)
            
            return url!
        }else{
            return URL.init(string: "")!
        }
    }
    
    

    func request(){
        SVProgressHUD.show(withStatus:"加载中")

       // print(getContinet,continent_id)
        
        let url = rootUrl+"/selectHotCountry"
        Alamofire.request(url, method: .post).responseJSON(completionHandler: {
            response in
            if let al = response.response{
                 print(al)
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
                        self.dataBase["nation_id"]?.append(json["data"][i]["country_code"].string!)
                    
                    }
                    SVProgressHUD.dismiss()
                    self.collectionView?.reloadData()
                }else{
                    SVProgressHUD.dismiss()                }
            }
            
        })
        
       // SVProgressHUD.dismiss()
        
    }
    

}

extension RecommendViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        //cell.backgroundColor = UIColor.yellow
        
        let national_flag = UIImageView(frame:FloatRect(0, 0, cell.contentView.frame.width, getHeight(151)))
        if self.dataBase["flag"]!.count>0{
            national_flag.sd_setImage(with:getImage(fg:self.dataBase["flag"]![indexPath.row] ), placeholderImage: #imageLiteral(resourceName: "baccc"), completed: nil);
        }
        
        let nation_name = UILabel(frame:Rect(89, 150+14, 0, 0))
        if self.dataBase["name"]!.count>0{
            nation_name.text = self.dataBase["name"]?[indexPath.row]
        }
        
        nation_name.font = UIFont.systemFont(ofSize: getHeight(26))
        nation_name.sizeToFit()
        
        national_flag.addSubview(nation_name)
        cell.addSubview(national_flag)
        
        
        return cell

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        for i in (self.navigationController?.navigationBar.subviews)!{
            i.removeFromSuperview()
        }
        self.navigationController?.pushViewController(BasicInformationViewController.init(title: "", defaultCode: 0), animated: true)


    }
    
    

}
