//
//  TLoginViewController.swift
//  Talk
//
//  Created by 杜洁鹏 on 16/8/12.
//  Copyright © 2016年 DW. All rights reserved.
//

class TLoginViewController: UIViewController {
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBAction func bgClicked(sender: AnyObject) {
        view.endEditing(true)
    }
    
    @IBAction func reigster(sender: AnyObject)
    {
        chatManager.asyncRegisterNewAccount(username.text, password: password.text, withCompletion: { (user, pwd, error) in
            if error == nil {
                self.showChooseAlert("注册", info: "直接登录？",  ifDone: {
                    self.login(sender)
                })
            } else {
                self.showRemindAlert("注册", info: "注册失败:\(error.description)")
            }
            
            }, onQueue: nil)
    }
    
    @IBAction func login(sender: AnyObject) {
        chatManager.asyncLoginWithUsername( username.text, password: password.text, completion:
            {
                (info, error) in
                if error == nil {
                    chatManager.enableAutoLogin!()
                    NSNotificationCenter.defaultCenter().postNotificationName(ChangeMainViewController, object: nil)
                    chatManager.loadDataFromDatabase()
                    chatManager.asyncFetchMyGroupsList()
                } else {
                    self.showRemindAlert("登录", info: "登录失败:\(error.description)")
                }
                
            },onQueue: nil)
    }
}


