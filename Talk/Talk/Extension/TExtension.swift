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