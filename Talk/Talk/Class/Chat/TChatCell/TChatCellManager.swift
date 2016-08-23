//
//  TChatCellManager.swift
//  Talk
//
//  Created by 杜洁鹏 on 16/8/22.
//  Copyright © 2016年 DW. All rights reserved.
//

import UIKit

class TChatCellManager: NSObject {

    func loadXibWithXibName(xibName: String!) -> AnyObject?{
        let xibs = NSBundle.mainBundle().loadNibNamed(xibName, owner: nil, options: nil) as Array
        return xibs.first
    }
}
