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
    
    var x: CGFloat {
        get {
            return self.frame.origin.x
        }
    }
    
    var y: CGFloat {
        get {
            return self.frame.origin.y
        }
    }
    
    var width: CGFloat {
        get {
            return self.frame.size.width
        }
    }
    
    var height: CGFloat {
        get {
            return self.frame.size.height
        }
    }
    
    func setX (x: CGFloat) {
        self.frame.origin.x = x
    }
    
    func setY (y: CGFloat) {
        self.frame.origin.y = y
    }
    
    func setWidth (width: CGFloat) {
        self.frame.size.width = width
    }
    
    func setHeight (height: CGFloat) {
        self.frame.size.height = height
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

//MARK: - LF_Insert
extension UIViewController {
    
    func showRemindAlert(title: String, info: String) {
        
        let alert = UIAlertController.init(title: title, message: info, preferredStyle: UIAlertControllerStyle.Alert)
        let action = UIAlertAction.init(title: "OK", style: UIAlertActionStyle.Cancel) { (alert) in
            
        }
        alert.addAction(action)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func showChooseAlert(title: String, info: String, ifDone actions:()->()) {
        let alert = UIAlertController.init(title: title, message: info, preferredStyle: UIAlertControllerStyle.Alert)
        let action1 = UIAlertAction.init(title: "Yes", style: UIAlertActionStyle.Default) { (action) in
            
            actions()
        }
        let action2 = UIAlertAction.init(title: "No", style: UIAlertActionStyle.Cancel) { (action) in
            
        }
        alert.addAction(action1)
        alert.addAction(action2)
        self.presentViewController(alert, animated: true, completion: nil)
    }
}