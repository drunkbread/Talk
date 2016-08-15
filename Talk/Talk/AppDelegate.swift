//
//  AppDelegate.swift
//  Talk
//
//  Created by 杜洁鹏 on 16/8/12.
//  Copyright © 2016年 DW. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        self.window = UIWindow.init(frame: UIScreen.mainScreen().bounds)
        addNotifications()
        EaseMob.sharedInstance().registerSDKWithAppKey("easemob-demo#chatdemoui", apnsCertName: "")
        EaseMob.sharedInstance().applicationDidFinishLaunching(application)
        showViewController()
        self.window?.makeKeyAndVisible()
        return true
    }
    
    func applicationWillResignActive(application: UIApplication) {
        EaseMob.sharedInstance().applicationWillResignActive(application)
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        EaseMob.sharedInstance().applicationDidEnterBackground(application)
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        EaseMob.sharedInstance().applicationWillEnterForeground(application)
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        EaseMob.sharedInstance().applicationDidBecomeActive(application)
    }
    
    func applicationWillTerminate(application: UIApplication) {
        EaseMob.sharedInstance().applicationWillTerminate(application)
    }
}

extension AppDelegate {
    
    func addNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: #selector(AppDelegate.showViewController),
            name: ChangeMainViewController,
            object: nil
        )
    }
    
    func showViewController() {
        if !isLogin {
            self.window?.rootViewController = UIStoryboard.viewControllerWithSB(
                stroyName: "Main",
                controllerID: "TLoginNavigationVontroller"
            )
        } else {
            self.window?.rootViewController = UIStoryboard.viewControllerWithSB(
                stroyName: "Main",
                controllerID: "TMainViewController"
            )
        }
    }
}

