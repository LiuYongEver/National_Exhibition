//
//  MoreChartViewController.swift
//  National_Exbihition
//
//  Created by ly on 2017/11/30.
//  Copyright © 2017年 shikeTeam. All rights reserved.
//

import UIKit

class MoreChartViewController: UIViewController {

    fileprivate var vview = MoreChartView()
    fileprivate var database:dataSelect?
    fileprivate var pickView:UIPickerView!
    fileprivate var selecteddata = [String]()
    fileprivate var clicktag = 0;
    
    override func viewDidLoad() {
        Alarequest()
        vview = MoreChartView(frame:self.view.frame)
        setPickview()

        self.navigationItem.title = "统计数据"
        let dict:NSDictionary = [NSAttributedStringKey.foregroundColor: UIColor.white,NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 18)]
        //标题颜色
    self.navigationController?.navigationBar.titleTextAttributes = dict as? [NSAttributedStringKey : Any]
        
        
    
        super.viewDidLoad()
        self.view.backgroundColor = backColor
        self.view.addSubview(vview)
        for i in vview.texts{
            i.addTarget(self, action: #selector(selector(_:)), for: .touchUpInside)
        }
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setPickview(){
        pickView = UIPickerView()
        pickView.frame = FloatRect(0 ,0 , SCREEN_WIDTH,180)
        pickView.selectRow(0,inComponent:0,animated:true)

        pickView.dataSource = self
        pickView.delegate = self
        pickView.isHidden = true
        self.vview.addSubview(pickView)
        self.vview.verifyButton.addTarget(self, action: #selector(verifyClicked), for: .touchUpInside)
        
    }
    
    
    
    
    @objc func selector(_ btn:UIButton){
        
        self.clicktag = btn.tag
        if let data = database{
            
        switch btn.tag {
        case 0:
            self.selecteddata = (data.continet)
        case 1:
            selecteddata = (data.dataType)
        case 2:
            selecteddata = (data.nation)
        case 3:
            selecteddata = data.time
        case 4:
            selecteddata = data.lastType
        case 5:
            selecteddata = data.population
        default:
            selecteddata = [""]
        }
       // print(selecteddata)
        }

        btn.isSelected = !btn.isSelected
        self.pickView.reloadAllComponents()
        let alert = UIAlertController.init(title: " \n\n\n\n\n\n\n\n\n\n", message: "", preferredStyle: .actionSheet)
        pickView.showsSelectionIndicator = true
        pickView.isHidden = true
        alert.view.addSubview(pickView)
        let cancel = UIAlertAction.init(title: "确定", style: .cancel, handler: nil)
        alert.addAction(cancel)
        
        self.present(alert, animated: true, completion: nil)
        
        
        
        if btn.isSelected{
            pickView.isHidden = false
        }else{
            pickView.isHidden = true
        }
    }
    
    
    @objc func verifyClicked(){
    
    
    }
    
    
    
    
    
    
    func Alarequest(){
        for i in 0...0{
        
            //self.selecteddata.append("无数据")
            
            self.database = dataSelect(continet:["亚洲","亚洲","亚洲","亚洲"],dataType:["类型","tyoe2","type3"],nation:["中国","日本"],time:["1997","2015","2017","2018"],lastType:["ty1","ty2","ty3"],population:["111","222"])
        }
        //print(database)
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
extension MoreChartViewController:UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if selecteddata != nil{
            return (self.selecteddata.count)
        }else{
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if selecteddata != nil{
            return self.selecteddata[row]
        }else{
            return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 20
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.vview.texts[clicktag].setTitle(selecteddata[row], for: .normal)
        
    }
    
    
}
