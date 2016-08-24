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
    override var model: TMessageCellModel!{
        didSet{
            contentLabel.text = model.messageTextContent()
        }
    }
}

