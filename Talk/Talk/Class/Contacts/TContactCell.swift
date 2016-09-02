//
//  TContactCell.swift
//  Talk
//
//  Created by EaseMob on 16/9/2.
//  Copyright © 2016年 DW. All rights reserved.
//

import UIKit

class TContactCell: UITableViewCell {


    @IBOutlet weak var headImageView: UIImageView!

    @IBOutlet weak var nameLabel: UILabel!
    
    var headImage: UIImage? {
        didSet {
            headImageView.image = headImage
        }
    }
    
    var contactName: String? {
        didSet {
            nameLabel.text = contactName
        }
    }
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
