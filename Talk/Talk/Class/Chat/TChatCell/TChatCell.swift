//
//  TChatCell.swift
//  Talk
//
//  Created by 杜洁鹏 on 16/8/18.
//  Copyright © 2016年 DW. All rights reserved.
//

import UIKit
import SDWebImage

class TChatCell: UITableViewCell {

    @IBOutlet weak var headImageView: UIImageView!
    @IBOutlet weak var bgImageView: UIImageView!
    var model: TMessageCellModel! {
        didSet{
            headImageView.sd_setImageWithURL(model.messageAvatar(), placeholderImage: nil)
        }
    }
}
