//
//  MapViewController.swift
//  National_Exbihition
//
//  Created by ly on 2017/12/13.
//  Copyright © 2017年 shikeTeam. All rights reserved.
//

import UIKit
import  MapKit
import CoreLocation
class MapViewController: UIViewController,BMKMapViewDelegate{
    var _mapView: BMKMapView?
    var _mapManager:BMKMapManager!
    var pointAnnotation: BMKPointAnnotation?
    var enableCustomMap = false
    
    var CLocation:[Float]!
    
        init(CLLocation:[Float]){
            super.init(nibName: nil, bundle: nil)
            self.CLocation = CLLocation
        }
    
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setMap()
        let topHeight = (self.navigationController?.navigationBar.frame.height)! + UIApplication.shared.statusBarFrame.height
        
        _mapView = BMKMapView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height - topHeight))
        self.view.addSubview(_mapView!)
        _mapView?.zoomLevel = 10
        
        addCustomGesture()//添加自定义手势
        
        //添加普通地图/个性化地图切换开关
        let segment = UISegmentedControl(items: ["普通地图", "卫星图"])
        segment.selectedSegmentIndex = 0
        segment.addTarget(self, action: #selector(changeMapAction(_:)), for: .valueChanged)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: segment)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        BMKMapView.enableCustomMapStyle(enableCustomMap)
        _mapView?.viewWillAppear()
        _mapView?.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        BMKMapView.enableCustomMapStyle(false)//消失时，关闭个性化地图
        _mapView?.viewWillDisappear()
        _mapView?.delegate = nil
    }
    
    @objc func changeMapAction(_ segment: UISegmentedControl) {
        /*
         *注：必须在BMKMapView对象初始化之前设置自定义地图样式，设置后会影响所有地图实例
         *设置方法：+ (void)customMapStyle:(NSString*) customMapStyleJsonFilePath;
         */
        if segment.selectedSegmentIndex == 1{
            _mapView?.mapType = UInt(BMKMapTypeSatellite)
        }else{
            _mapView?.mapType = UInt(BMKMapTypeStandard)
        }
        
        //enableCustomMap = segment.selectedSegmentIndex == 1
        //打开/关闭个性化地图
        //BMKMapView.enableCustomMapStyle(enableCustomMap)
    }
    
    // MARK: - BMKMapViewDelegate
    
    /**
     *地图初始化完毕时会调用此接口
     *@param mapview 地图View
     */
    func mapViewDidFinishLoading(_ mapView: BMKMapView!) {
        addPointAnnotation()
        _mapView?.setCenter(CLLocationCoordinate2D.init(latitude: Double(CLocation[0]), longitude: Double(CLocation[1])), animated: true)
//        let alertVC = UIAlertController(title: "", message: "BMKMapView控件初始化完成", preferredStyle: .alert)
//        let alertAction = UIAlertAction(title: "知道了", style: .cancel, handler: nil)
//        alertVC.addAction(alertAction)
//        //self .present(alertVC, animated: true, completion: nil)
    }
    
    // MARK: - 添加自定义手势 （若不自定义手势，不需要下面的代码）
    func addCustomGesture() {
        /*
         *注意：
         *添加自定义手势时，必须设置UIGestureRecognizer的cancelsTouchesInView 和 delaysTouchesEnded 属性设置为false，否则影响地图内部的手势处理
         */

    }
    
    func addPointAnnotation() {
            if pointAnnotation == nil {
                pointAnnotation = BMKPointAnnotation()
                pointAnnotation?.coordinate = CLLocationCoordinate2DMake(Double(CLocation[0]), Double(CLocation[1]))
                pointAnnotation?.title = "我是pointAnnotation"
                pointAnnotation?.subtitle = "此Annotation可拖拽!"
            }
            _mapView?.addAnnotation(pointAnnotation)
            _mapView?.setCenter(CLLocationCoordinate2DMake(39.915, 116.404), animated: true)
        }
    
    
    func handleSingleTap(_ tap: UITapGestureRecognizer) {
        NSLog("custom single tap handle")
    }
}

//    var mainMapView: MKMapView!
//    var _mapManager: BMKMapManager?
//    var _mapView: BMKMapView?
//    var pointAnnotation: BMKPointAnnotation?
//    var CLocation:[Float]!
//
//    init(CLLocation:[Float]){
//        super.init(nibName: nil, bundle: nil)
//        self.CLocation = CLLocation
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    func setMap(){
//        _mapManager = BMKMapManager()
//        // 如果要关注网络及授权验证事件，请设定generalDelegate参数
//        let ret = _mapManager?.start("8rylxkmAX2djYcmZemKcfqnmFK9Gjt4m", generalDelegate: self)
//        if ret == false {
//            NSLog("manager start failed!")
//            return
//        }
//
//        _mapView = BMKMapView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
//        addPointAnnotation(
//        )
//        self.view.addSubview(_mapView!)
//
//    }
//
//
//    //添加标注
//    func addPointAnnotation() {
//        if pointAnnotation == nil {
//            pointAnnotation = BMKPointAnnotation()
//            pointAnnotation?.coordinate = CLLocationCoordinate2DMake(39.915, 116.404)
//            pointAnnotation?.title = "我是pointAnnotation"
//            pointAnnotation?.subtitle = "此Annotation可拖拽!"
//        }
//        _mapView?.addAnnotation(pointAnnotation)
//        _mapView?.setCenter(CLLocationCoordinate2DMake(39.915, 116.404), animated: true)
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        _mapView?.viewWillAppear()
//        _mapView?.delegate = self // 此处记得不用的时候需要置nil，否则影响内存的释放
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        _mapView?.viewWillDisappear()
//        _mapView?.delegate = nil // 不用时，置nil
//    }
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setMap()
////        //使用代码创建
////        self.mainMapView = MKMapView(frame:self.view.frame)
////        self.view.addSubview(self.mainMapView)
////
////        //地图类型设置 - 标准地图
////        self.mainMapView.mapType = MKMapType.standard
////
////        //创建一个MKCoordinateSpan对象，设置地图的范围（越小越精确）
////        let latDelta = 0.05
////        let longDelta = 0.05
////        let currentLocationSpan:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
////
////        //定义地图区域和中心坐标（
////        //使用当前位置
////        //var center:CLLocation = locationManager.location.coordinate
////        //使用自定义位置
////        //lati  long
////
////        let center:CLLocation = CLLocation(latitude: Double(self.CLocation[0]), longitude: Double(self.CLocation[1]))
////        let currentRegion:MKCoordinateRegion = MKCoordinateRegion(center: center.coordinate,
////                                                                  span: currentLocationSpan)
////
////        //设置显示区域
////        self.mainMapView.setRegion(currentRegion, animated: true)
////
////        //创建一个大头针对象
////        let objectAnnotation = MKPointAnnotation()
////        //设置大头针的显示位置
////        objectAnnotation.coordinate = CLLocation(latitude: 32.029171,
////                                                 longitude: 118.788231).coordinate
////        //设置点击大头针之后显示的标题
////        objectAnnotation.title = "南京夫子庙"
////        //设置点击大头针之后显示的描述
////        objectAnnotation.subtitle = "南京市秦淮区秦淮河北岸中华路"
////        //添加大头针
////        self.mainMapView.addAnnotation(objectAnnotation)
//    }
//
//}

