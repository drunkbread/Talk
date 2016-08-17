//
//  TExtension.swift
//  Talk
//
//  Created by 杜洁鹏 on 16/8/12.
//  Copyright © 2016年 DW. All rights reserved.
//


extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        
        set {
            if newValue > 0 {
                self.layer.masksToBounds = true
            } else {
                self.layer.masksToBounds = false
            }
            self.layer.cornerRadius = newValue
        }
    }
}

extension UITabBar {
    @IBInspectable var selectedColor: UIColor {
        get {
            return tintColor
        }
        
        set {
            tintColor = newValue
        }
    }
}

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
        let today = NSDate.today()
        
        if  date.isInToday() {
            return self.formattedTimeHHmm(date)
        } else if today.add(days: -1).isInSameDayAsDate(date) /* 昨天 */ {
            return "昨天"
        } else if today.add(days: -2).isInSameDayAsDate(date) /* 前天 */ {
            return "前天"
        } else if (today.weekday == date.weekday) /* 本周 */ {
            return formattedTimeMMddHHmm(date)
        } else if (today.year == date.year) /* 本年 */ {
            return formattedTimeMMddHHmm(date)
        } else { /* 非本年 */
            return formattedTimeYYYYMMddHHmm(date)
        }
    }
    
    func formattedTimeYYYYMMddHHmm(time: NSDate) -> String {
        let dataFormatter = NSDateFormatter()
        dataFormatter.dateFormat = "yyyy年MM月dd日 HH:mm"
        return dataFormatter.stringFromDate(time)
    }
    
    func formattedTimeMMddHHmm(time: NSDate) -> String {
        let dataFormatter = NSDateFormatter()
        dataFormatter.dateFormat = "MM月dd日 HH:mm"
        return dataFormatter.stringFromDate(time)
    }
    
    func formattedTimeHHmm(time: NSDate) -> String {
        let dataFormatter = NSDateFormatter()
        dataFormatter.dateFormat = "HH:mm"
        return dataFormatter.stringFromDate(time)
    }
}