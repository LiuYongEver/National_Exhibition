//
//  PublicFunc.swift
//  National_Exbihition
//
//  Created by ly on 2017/12/22.
//  Copyright © 2017年 shikeTeam. All rights reserved.
//

import Foundation






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
        return URL.init(string: rootUrl)!
    }
}



func getUrls(str:String) -> [String] {
    var urls = [String]()
    do {
        let dataDetector = try NSDataDetector(types:NSTextCheckingTypes(NSTextCheckingResult.CheckingType.link.rawValue))
        // 匹配字符串，返回结果集
        let res = dataDetector.matches(in: str,options: NSRegularExpression.MatchingOptions(rawValue: 0),range: NSMakeRange(0, str.characters.count))
        for checkingRes in res {
            urls.append((str as NSString).substring(with: checkingRes.range))
        }
    } catch {
        print(error)
    }
    return urls
}


func getReFArray(value:String,url:[String])->[String]{
    var aray = [String]()
    var titleString = value
    for i in url{
        titleString = titleString.replacingOccurrences(of: i, with: "#")
    }
    
    // print(titleString)
    titleString =   titleString.replacingOccurrences(of: "网址", with: "")
    titleString =  titleString.replacingOccurrences(of: "：", with: "")
    aray = titleString.components(separatedBy: "#")
    var new = [String]()
    if url.count>0{
        for i in 0...url.count-1{
            new.append(aray[i])
        }
    }
    return new
    
}


//func getArrayFromWeb() {
//    let manager = AFHTTPSessionManager()
//    manager.get("http://www.douyutv.com/api/v1/slide/6", parameters: ["version" : "2.300"], progress: nil, success: { (task:URLSessionDataTask, json:Any) in
//        //            print("jsonData: \(json)")
//        guard let dataDic = json as? [String : NSObject] else { return }
//        guard let dataArr = dataDic["data"] as? [[String : NSObject]] else { return }
//        for dic in dataArr {
//            self.modelArr.append(CarouselModel(dic: dic))
//        }
//        self.carouselView.carouselModelArr = self.modelArr
//    }) { (task:URLSessionDataTask?, error:Error) in
//        print("error : \(error)")
//    }
//}



