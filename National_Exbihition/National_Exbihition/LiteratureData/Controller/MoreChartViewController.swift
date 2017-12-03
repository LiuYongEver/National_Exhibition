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
    
    override func viewDidLoad() {
        Alarequest()
        vview = MoreChartView(frame:self.view.frame)
        setPickview()

        self.navigationItem.title = "统计数据"
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
        //pickView.frame = FloatRect(0 ,SCREEN_WIDTH-80 , SCREEN_WIDTH,80)
        pickView.selectRow(0,inComponent:0,animated:true)

        pickView.dataSource = self
        pickView.delegate = self
        pickView.isHidden = true
        self.vview.addSubview(pickView)
        
    }
    
    
    
    @objc func selector(_ btn:UIButton){
        switch btn.tag {
        case 0:
            self.selecteddata = (database?.continet)!
        default:
            selecteddata = (database?.dataType)!
        }
        print(selecteddata)

        btn.isSelected = !btn.isSelected
        self.pickView.reloadAllComponents()
        let alert = UIAlertController.init(title: " \n\n\n\n\n\n\n\n\n\n", message: "", preferredStyle: .actionSheet)
        pickView.showsSelectionIndicator = true
        pickView.isHidden = true
        alert.view.addSubview(pickView)
        self.present(alert, animated: true, completion: nil)
        
        
        
        if btn.isSelected{
            pickView.isHidden = false
        }else{
            pickView.isHidden = true
        }
        
        
    }
    
    func Alarequest(){
        for i in 0...5{
        
            //self.selecteddata.append("无数据")
            
            self.database = dataSelect(continet:["亚洲\(i)","亚洲\(i)","亚洲\(i)","亚洲\(i)"],dataType:["亚洲\(i)"],nation:["亚洲\(i)"],time:["亚洲\(i)"],lastType:["亚洲\(i)"])
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
    
    
    
}
