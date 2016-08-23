//
//  TChatTextCell.swift
//  Talk
//
//  Created by 杜洁鹏 on 16/8/19.
//  Copyright © 2016年 DW. All rights reserved.
//

import UIKit

class TChatTextCell: TChatCell {
    @IBOutlet weak var contentLabel: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
