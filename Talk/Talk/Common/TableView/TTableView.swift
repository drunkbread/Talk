//
//  TTableView.swift
//  Talk
//
//  Created by 杜洁鹏 on 16/8/12.
//  Copyright © 2016年 DW. All rights reserved.
//

import UIKit

class TTableView: UITableView {    
    override func awakeFromNib() {
        super.awakeFromNib()
        hiddenFootView()
    }
}
