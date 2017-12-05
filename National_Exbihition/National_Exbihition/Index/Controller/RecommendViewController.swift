//
//  RecommendViewController.swift
//  National_Exbihition
//
//  Created by ly on 2017/11/9.
//  Copyright © 2017年 shikeTeam. All rights reserved.
//

import UIKit

class RecommendViewController: UIViewController {
    
    let layout = UICollectionViewFlowLayout()
    var collectionView: UICollectionView?
    
 
    
    override func viewDidLoad() {
        setCollectionView()
        self.view.backgroundColor = backColor
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
    let animation = CATransition.init()
    animation.duration = 0.5;
    animation.type = kCATransitionFade
    animation.subtype = kCATransitionFromRight
    self.view.window?.layer.add(animation, forKey: nil);
    let nav = UINavigationController(rootViewController:AllCountryViewController())
    self.present(nav, animated: false, completion: nil)
        //self.navigationController?.pushViewController(AllCountryViewController(), animated: true)
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

extension RecommendViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        //cell.backgroundColor = UIColor.yellow
        
        let national_flag = UIImageView(frame:FloatRect(0, 0, cell.contentView.frame.width, getHeight(151)))
        national_flag.image = #imageLiteral(resourceName: "组 183")
        
        let nation_name = UILabel(frame:Rect(89, 150+14, 0, 0))
        nation_name.text = "中国"
        nation_name.font = UIFont.systemFont(ofSize: getHeight(26))
        nation_name.sizeToFit()
        
        national_flag.addSubview(nation_name)
        cell.addSubview(national_flag)
        
        
        return cell

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let nav = UINavigationController.init(rootViewController: BasicInformationViewController.init(title: "中国"))
        let animation = CATransition.init()
        animation.duration = 0.5;
        animation.type = kCATransitionFade
        animation.subtype = kCATransitionFromRight
        self.view.window?.layer.add(animation, forKey: nil)
        self.present(nav, animated:false, completion: nil)

    }
    
    
    
    
}
