//
//  PoliticView.swift
//  National_Exbihition
//
//  Created by ly on 2017/12/13.
//  Copyright © 2017年 shikeTeam. All rights reserved.
//


import Foundation
import UIKit
import Alamofire
import SVProgressHUD

class PoliticView:UIScrollView{
    var psdelegate:PushVCDelegate?
    var carouselView:SliderGalleryController!
    var modelArr = [String]()
    var country_code:String!
    var database:[String:String]=[
        "现任首脑":"",
        "就任时间":"",
        "宪法":"",
        "政府机关":"",
        "政体":"",
        "议会":"",
        "政党情况":"",
        "政治变迁":"",
        "其他政治信息":"",
        "司法机关":"",
        "政治人物":"",
        "军事概览":"",
        "来源":"",
        "统计报表":"",
        "相关文献":"",
        "图片":""
        ]
    
    
    
    lazy var textView1:UITextView = {
        let Text = UITextView.init()
        return Text
    }()
    var back:UIView!
    
    
    
    init(frame: CGRect,country_code:String) {
        super.init(frame: frame)
        self.country_code = country_code
        Alarequest()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    
    func setText(){
        back = UIView.init(frame: self.frame)
        //back.contentSize = CGSize(width:SCREEN_WIDTH,height:SCREEN_HEIGHT*1.2)
        self.addSubview(back)

        textView1.isEditable = false
        textView1.textColor = title2color
        //textView1.attributedText = getText();
        textView1.frame = FloatRect(getWidth(0),getHeight(10),SCREEN_WIDTH,SCREEN_HEIGHT-104);
        textView1.bounces = false
        back.addSubview(textView1)
        textView1.attributedText = getText()
        setCarouselView()
        
    }
    
    func getText()->NSMutableAttributedString{
        var atrrString:String  = ""
        let ll = NSMutableAttributedString()
        for (key,value) in self.database{
            if value != ""{
                //print(key)
                if key == "军事概览" || key == "统计报表" || key == "来源" || key == "相关文献" { continue }
                if value.count>100{
                    ll.append(NumsCountDeal(key: key))
                    continue
                }else{
                    atrrString = atrrString + key + ":  " + value + "\n\n";
                }
            }

        }
        
        
        ll.append(NumsCountDeal(key: "军事概览"))
        ll.append(NumsCountDeal(key: "来源"))
        ll.append(NumsCountDeal(key: "相关文献"))
        ll.append(NumsCountDeal(key: "统计报表"));
        
        let m = NSMutableAttributedString.init(string: atrrString, attributes:  [NSAttributedStringKey.foregroundColor : title2color, NSAttributedStringKey.font : UIFont.systemFont(ofSize: getHeight(32))])
        m.append(ll)
        
        return m
    }
    
    func NumsCountDeal(key:String)->NSMutableAttributedString{
        let IMG  = #imageLiteral(resourceName: "LLine")
        let ttAttach = NSTextAttachment()
        var ll = NSMutableAttributedString()
        ttAttach.image = IMG
        ttAttach.bounds = FloatRect(-10,0,SCREEN_WIDTH,getHeight(15))
        ll.append(NSAttributedString.init(attachment: ttAttach))
        
        let titleatrString = NSAttributedString.init(string: "\(key)\n\n", attributes:  [NSAttributedStringKey.foregroundColor : title1Color, NSAttributedStringKey.font : UIFont.systemFont(ofSize: getHeight(42))])
        ll.append(titleatrString)
        
        if let gg =  self.database[key]{
            
            
            if key == "来源"{
                let array = getUrls(str: gg)
                let titleString = getReFArray(value: gg, url: array)
                print(titleString)
                
                if array.count == titleString.count && titleString.count>0{
                    for i in 0...array.count-1{
                        let reft = NSMutableAttributedString.init(string: titleString[i]+"\n\n", attributes:  [NSAttributedStringKey.foregroundColor : title2color, NSAttributedStringKey.font : UIFont.systemFont(ofSize: getHeight(32))])
                        
                        reft.addAttribute(NSAttributedStringKey.link, value: array[i], range: NSRange.init(location: 0, length:titleString[i].count))
                        ll.append(reft)
                    }
                    return ll
                }
            }
            
            
            let atrString = NSMutableAttributedString.init(string: gg+"\n\n", attributes:  [NSAttributedStringKey.foregroundColor : title2color, NSAttributedStringKey.font : UIFont.systemFont(ofSize: getHeight(32))])
            
            ll.append(atrString)
        }
        return ll
    }
    
    func Alarequest(){
        let url = rootUrl+"/find_politic_pk"
        print(country_code)
        let paramete = ["country_code":"\(country_code!)"]
        print(paramete)
        Alamofire.request(url, method: .post,parameters:paramete).responseJSON(completionHandler: {
            response in
            if let al = response.response{
                // print(al)
              //  print(response.result.isSuccess)
            }else{
                SVProgressHUD.showError(withStatus: "网络连接失败")
                SVProgressHUD.dismiss(withDelay: 1)
            }
            
            if let js = response.result.value{
                let json = JSON(js)//["data"]
               // print(json)
                if let gg = json["data"]["leader"].string{
                    self.database["现任首脑"] = gg
                }
                if let gg = json["data"]["office_time"].string{
                    self.database["就任时间"] = gg
                }
                if let gg = json["data"]["constitution"].string{
                    self.database["宪法"] = gg
                }
                if let gg = json["data"]["government"].string{
                    self.database["政府机关"] = gg
                }
                if let gg = json["data"]["political_persons"].string{
                    self.database["政治人物"] = gg
                }
                if let gg = json["data"]["military"].string{
                    self.database["军事概览"] = gg
                }
                if let gg = json["data"]["judiciary"].string{
                    self.database["司法机关"] = gg
                }
                if let gg = json["data"]["parliament"].string{
                    self.database["议会"] = gg
                }
                if let gg = json["data"]["parties"].string{
                    self.database["政党情况"] = gg
                }
                
                if let gg = json["data"]["political_changes"].string{
                    self.database["政治变迁"] = gg
                }
                if let gg = json["data"]["other_information"].string{
                    self.database["其他政治信息"] = gg
                }
                if let gg = json["data"]["reference"].string{
                    self.database["来源"] = gg
                }
                if let gg = json["data"]["statistics"].string{
                    self.database["统计报表"] = gg
                }
                if let gg = json["data"]["conferences"].string{
                    self.database["相关文献"] = gg
                }
                if let gg = json["data"]["picture"].string{
                    self.database["图片"] = gg
                }
                
                
                DispatchQueue.main.async {
                    self.setText()
                }
                
                
            }
        })
        
    }
}

extension PoliticView:SliderGalleryControllerDelegate{
    
    // MARK: - 轮播图协议
    //图片轮播组件协议方法：获取内部scrollView尺寸
    
    func initSliderView(){
        
        
        //初始化图片轮播组件
        textView1.isScrollEnabled = false
        //改变textview高度和Scrollview显示高度
        let size = textView1.sizeThatFits(CGSize.init(width: textView1.frame.width, height: CGFloat(MAXFLOAT)))
        // CGSize size = [textView sizeThatFits:CGSizeMake(CGRectGetWidth(textView.frame), MAXFLOAT)];
        var  frame = textView1.frame;
        frame.size.height = size.height;
        textView1.frame = frame
        self.contentSize = CGSize.init(width: SCREEN_WIDTH, height: getHeight(407)+size.height+104)
        carouselView = SliderGalleryController()
        carouselView.delegate = self
        //(frame: Rect(105, 10, 540, 364))
        carouselView.view.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH,
                                         height: getHeight(364));
        carouselView.view.backgroundColor = UIColor.white
        //将图片轮播组件添加到当前视图
        //self.addChildViewController(carouselView)
        
        self.addSubview(carouselView.view)
        
        //添加组件的点击事件
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(handleTapAction(_:)))
        carouselView.view.addGestureRecognizer(tap)
        
        
    }
    
    
    
    func galleryScrollerViewSize() -> CGSize {
        return CGSize(width: SCREEN_WIDTH, height:getHeight(364))
    }
    
    //图片轮播组件协议方法：获取数据集合
    func galleryDataSource() -> [String] {
        return self.modelArr
    }
    
    //点击事件响应
    @objc func handleTapAction(_ tap:UITapGestureRecognizer)->Void{
        
        //        //获取图片索引值
        let index = carouselView.currentIndex
        self.psdelegate?.present(vc:ImageDetailViewController.init(model: self.modelArr, cuIndex: index) )//.Push(vc:
    }
    
    
    func setCarouselView(){
        if (self.database["图片"] != "") {
            
            let imaArr = self.database["图片"]
            let arr =  imaArr?.components(separatedBy: ",")
            for i in arr!{
                let  dataDic = imageUrl+i.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
                modelArr.append(dataDic)
                //print(dataDic)
            }
            
            //carouselView.carouselModelArr = self.modelArr
            self.textView1.frame = FloatRect(getWidth(0),getHeight(364),SCREEN_WIDTH,SCREEN_HEIGHT-104)
            initSliderView()
            //self.addSubview(carouselView.view)
        }
    }
    
    
    
}




