//
//  Propoty.swift
//  National_Exbihition
//
//  Created by ly on 2017/11/8.
//  Copyright © 2017年 shikeTeam. All rights reserved.
//

import Foundation
import UIKit

let SCREEN_HEIGHT = UIScreen.main.bounds.height
let SCREEN_WIDTH = UIScreen.main.bounds.width
let naviColor = UIColor.init(red: 0/255, green: 143/255, blue: 216/255, alpha: 1)
let rootUrl = "http://112.74.36.246:8080/nation/api"
let imageUrl = "http://112.74.36.246:8080/"



extension UIColor{
    class var randomColor: UIColor {
        get{
            let red = CGFloat((arc4random()%255))/255.0
            let green = CGFloat((arc4random()%255))/255.0
            let blue = CGFloat((arc4random()%255))/255.0
            return UIColor(red:red,green:green,blue:blue,alpha:1)
        }
        
    }
}


func timeFormat(_ tt:Int)->String{
    let date  =  Date.init(timeIntervalSince1970: TimeInterval(tt/1000))
    let formatter = DateFormatter()
    formatter.dateFormat = "MMM d, yyyy, hh:mm a"
    return formatter.string(from: date)
    
}


public func setNavi(nav:UINavigationController){
    nav.navigationBar.barTintColor = naviColor
    nav.navigationBar.isTranslucent = false
    nav.navigationBar.tintColor = UIColor.white
    nav.navigationItem.backBarButtonItem?.tintColor = UIColor.white
}



public func hexStringToColor(hexString: String) -> UIColor{
    
    var cString: String = hexString.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
    
    if cString.characters.count < 6 {
        return UIColor.black
    }
    if cString.hasPrefix("0X") {
        cString = cString.substring(from: cString.index(cString.startIndex, offsetBy: 2))
    }
    if cString.hasPrefix("#") {
        cString = cString.substring(from: cString.index(cString.startIndex, offsetBy: 1))
    }
    if cString.characters.count != 6 {
        return UIColor.black
    }
    
    var range: NSRange = NSMakeRange(0, 2)
    let rString = (cString as NSString).substring(with: range)
    range.location = 2
    let gString = (cString as NSString).substring(with: range)
    range.location = 4
    let bString = (cString as NSString).substring(with: range)
    
    var r: UInt32 = 0x0
    var g: UInt32 = 0x0
    var b: UInt32 = 0x0
    Scanner.init(string: rString).scanHexInt32(&r)
    Scanner.init(string: gString).scanHexInt32(&g)
    Scanner.init(string: bString).scanHexInt32(&b)
    
    return UIColor(displayP3Red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: CGFloat(1))
    
}

func getHeight(_ height: Double) -> CGFloat{
    return CGFloat(height/1334)*(SCREEN_HEIGHT)
}

func getWidth(_ width :Double) -> CGFloat {
    return  CGFloat(width/750)*(SCREEN_WIDTH)
}


public func Rect(_ x:Double,_ y:Double,_ w:Double,_ h:Double)->CGRect{
    
    return CGRect(x:getWidth(x),y:getHeight(y),width:getWidth(w),height:getHeight(h))
}
public func FloatRect(_ x:CGFloat,_ y:CGFloat,_ w:CGFloat,_ h:CGFloat)->CGRect{
    
    return CGRect(x:x,y:y,width:w,height:h)
}


  //状态栏20 导航条 44 tabbar 49

let title2color = hexStringToColor(hexString: "#7a7a7a")
let backColor = UIColor.white //hexStringToColor(hexString:"#fafafa")
let lineColor = hexStringToColor(hexString:"#dddddd")
let title1Color = hexStringToColor(hexString:"#333333")
