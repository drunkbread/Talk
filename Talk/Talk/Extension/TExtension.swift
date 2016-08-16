//
//  TExtension.swift
//  Talk
//
//  Created by 杜洁鹏 on 16/8/12.
//  Copyright © 2016年 DW. All rights reserved.
//


extension UITableView {
    func hiddenFootView() {
        tableFooterView = UIView()
    }
}

extension UIStoryboard {
    class func viewControllerWithSB(stroyName name:String, controllerID: String) -> UIViewController {
        return UIStoryboard.init(name: name, bundle: nil).instantiateViewControllerWithIdentifier(controllerID)
    }
}

extension NSNotificationCenter {

}

extension String {
    
}

// TIME
extension NSDate{
    func UnixTimestampToString(unixTime: Double) -> String {
        var dUnixTime = unixTime
        if dUnixTime > 140000000000 {
            dUnixTime = dUnixTime/1000
        }
        let date = NSDate.init(timeIntervalSince1970: dUnixTime)
        return self.formattedTimeYYYYMMddHHmmss(date)
    }
    
    func formattedTimeYYYYMMddHHmmss(time: NSDate) -> String {
        let dataFormatter = NSDateFormatter()
        dataFormatter.dateFormat = "yyyy年MM月dd日 HH:mm:ss"
        return dataFormatter.stringFromDate(time)
    }
    
    func formattedTimeMMddHHmmss(time: NSDate) -> String {
        let dataFormatter = NSDateFormatter()
        dataFormatter.dateFormat = "MM月dd日 HH:mm:ss"
        return dataFormatter.stringFromDate(time)
    }
    
    func formattedTimeHHmmss(time: NSDate) -> String {
        let dataFormatter = NSDateFormatter()
        dataFormatter.dateFormat = "HH:mm:ss"
        return dataFormatter.stringFromDate(time)
    }
}