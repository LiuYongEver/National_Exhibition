//
//  ImageDetailViewController.swift
//  National_Exbihition
//
//  Created by ly on 2017/12/24.
//  Copyright © 2017年 shikeTeam. All rights reserved.
//

import UIKit

class ImageDetailViewController: UIViewController {

    var carouselView:SliderGalleryController!
    var modelArr = [String]()
    var currentIndex = Int()
    
    init(model:[String],cuIndex:Int) {
        super.init(nibName: nil, bundle: nil)
        self.currentIndex = cuIndex
        self.modelArr = model
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        setCarouselView()
        self.view.backgroundColor = UIColor.black
        let backbutton = UIButton(type: .custom)
        backbutton.frame = CGRect(x: 0, y: 0, width:88, height: 80)
        //backbutton.setImage(UIImage(named: "back@1x"), for: .normal)
        let bti = UIImageView.init(frame:( CGRect(x:15, y: 13+15, width: 22, height: 22)))
        bti.image = #imageLiteral(resourceName: "back@1x")
        self.view.addSubview(bti)
        backbutton.backgroundColor = UIColor.clear
        backbutton.addTarget(self, action: #selector(diss), for: .touchUpInside)
        self.view.addSubview(backbutton)
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @objc func diss(){
        self.dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
extension ImageDetailViewController:SliderGalleryControllerDelegate{
    // MARK: - 轮播图协议
    //图片轮播组件协议方法：获取内部scrollView尺寸
    
    func initSliderView(){
        
        
        //初始化图片轮播组件
       
        carouselView = SliderGalleryController()
        carouselView.delegate = self
        carouselView.currentIndex = self.currentIndex
        carouselView.didIntTimer()
        //(frame: Rect(105, 10, 540, 364))
        carouselView.view.frame = CGRect(x: 0, y: SCREEN_HEIGHT/6, width: SCREEN_WIDTH,
                                         height: SCREEN_HEIGHT);
        carouselView.view.backgroundColor = UIColor.white
        //将图片轮播组件添加到当前视图
        //self.addChildViewController(carouselView)
        carouselView.view.backgroundColor = UIColor.black
        
        self.view.addSubview(carouselView.view)
        
        //添加组件的点击事件
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(handleTapAction(_:)))
        carouselView.view.addGestureRecognizer(tap)
        
        
    }
    
    
    
    func galleryScrollerViewSize() -> CGSize {
        return CGSize(width: SCREEN_WIDTH, height:SCREEN_HEIGHT*2/3)
    }
    
    //图片轮播组件协议方法：获取数据集合
    func galleryDataSource() -> [String] {
        return self.modelArr
    }
    
    //点击事件响应
    @objc func handleTapAction(_ tap:UITapGestureRecognizer)->Void{
        
//        UIView.animate(withDuration: 0.5, animations: {
//            self.carouselView.view.frame = FloatRect(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
//        })

    }
    
    
    func setCarouselView(){
        
            initSliderView()
            //self.addSubview(carouselView.view)
        }
    
    
    
}
