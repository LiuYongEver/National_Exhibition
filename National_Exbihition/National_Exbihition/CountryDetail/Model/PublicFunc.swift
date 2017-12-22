//
//  PublicFunc.swift
//  National_Exbihition
//
//  Created by ly on 2017/12/22.
//  Copyright © 2017年 shikeTeam. All rights reserved.
//

import Foundation

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
