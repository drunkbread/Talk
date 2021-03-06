//
//  TNavigationController.swift
//  Talk
//
//  Created by 杜洁鹏 on 16/8/12.
//  Copyright © 2016年 DW. All rights reserved.
//

import UIKit

class TNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 修改navigationBar 显示的 字体样式
        navigationBar.titleTextAttributes = [
            NSFontAttributeName : UIFont.systemFontOfSize(18, weight: 3)
        ]
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
