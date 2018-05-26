//
//  askView.swift
//  National_Exbihition
//
//  Created by 刘勇 on 2018/5/6.
//  Copyright © 2018年 shikeTeam. All rights reserved.
//

import UIKit
import SVProgressHUD

protocol askViewDelegate {
    
    func present(vc:UIViewController)
    func push(vc:UIViewController)
    
    
}



class askView: UIView {
    
    
    var delegate:askViewDelegate?
    var typeCode:String?
    var relevant:String?
    
    @IBOutlet weak var OkButton: UIButton!
    @IBOutlet weak var titleTet: UITextField!
    
     @IBOutlet weak var DetailText: UITextView!
    

    @IBAction func addImage(_ sender: Any) {
        delegate?.present(vc: self.imagePickerController)
    }
    
    @IBOutlet weak var InviteSome: UIButton!
    @IBOutlet weak var Image: UIImageView!
    
    @IBOutlet weak var nameOfNation: UITextField!
    
    @IBAction func selectType(_ sender: Any) {
        let drop = DropListView.init(frame:Rect(0, 80, 330, 80), arrData: ["基本信息","环境资源","政治军事","经济发展","社会状况","科技教育","国际关系","侨情"],completion: ({
            list in
            
            self.typeCode = self.getIndex(index: list as String).Index
            let m = sender as! UIButton
            m.setTitle( "    " + (list as String) as String, for: .normal)
            //self.request(week: list as String)
            //print(list)
        }))
        drop.tabWidth = getWidth(530)
        drop.tabOffset = 200
        drop.showList()
    }
    
  
    
    

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        
        self.InviteSome.addTarget(self, action: #selector(invite), for: .touchUpInside)
        
        // Drawing code
    }
    

}





extension askView:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    var imagePickerController:UIImagePickerController{
        get{
            let imagePicket = UIImagePickerController()
            imagePicket.delegate = self
            imagePicket.sourceType = .photoLibrary
            return imagePicket
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
         picker.dismiss(animated: true, completion: nil)
         self.Image.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        Image.contentMode = .scaleAspectFit
        
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    
    func getIndex(index:String)->(Index:String,IndexCode:Int){
        let indexx = ["","nationinfo","nature","politic","development","society","technology","relationship","overseas",""]
        let ttitle  =  ["推荐","基本信息","环境资源","政治军事","经济发展","社会状况","科技教育","国际关系","侨情","国际数据"]
        for i in 0...ttitle.count-1{
            if ttitle[i] == index{
                return (indexx[i],i)
            }
            
        }
        return ("",0)
    }
    
    
    
    func resign(){
        self.DetailText.resignFirstResponder()
        self.titleTet.resignFirstResponder()
        self.nameOfNation.resignFirstResponder()
        
    }
    
    
}


extension askView:getFocusListDelegate{
    
    func getFocus(name: String, id: Int) {
        self.InviteSome.setTitle(name, for: .normal)
        self.relevant = "\(id)"
    }
    
   @objc func invite(){
        let vc = FocusTableViewController()
        vc.getFoucsdelegate = self
        self.delegate?.push(vc:vc)
    }
    
    
    
}
