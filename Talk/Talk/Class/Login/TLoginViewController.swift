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
    
    @IBAction func reigster(sender: AnyObject) {
     
    }
    
    @IBAction func login(sender: AnyObject) {
        chatManager.asyncLoginWithUsername( username.text, password: password.text, completion:
            {
                (info, error) in
                if error == nil {
                    chatManager.enableAutoLogin!()
                    NSNotificationCenter.defaultCenter().postNotificationName(ChangeMainViewController, object: nil)
                }
                
            },onQueue: nil)
    }
}


