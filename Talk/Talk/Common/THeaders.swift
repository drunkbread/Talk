//
//  THeaders.swift
//  Talk
//
//  Created by 杜洁鹏 on 16/8/12.
//  Copyright © 2016年 DW. All rights reserved.
//


let chatManager = EaseMob.sharedInstance().chatManager

var isLogin: Bool {
    return chatManager.isAutoLoginEnabled!
}

// MARK - defineName
let ChangeMainViewController = "ChangeMainViewController"


