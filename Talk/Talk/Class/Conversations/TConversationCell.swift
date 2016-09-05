//
//  TConversationCell.swift
//  Talk
//
//  Created by 杜洁鹏 on 16/8/15.
//  Copyright © 2016年 DW. All rights reserved.
//

class TConversationCell: UITableViewCell {
    
    @IBOutlet weak var conversationAvatar: UIImageView!
    @IBOutlet weak var conversationShowName: UILabel!
    @IBOutlet weak var conversationMsgInfo: UILabel!
    @IBOutlet weak var conversationLastUpdateTime: UILabel!
    @IBOutlet weak var conversationUnreadCountLabel: UILabel!
    
    var conversationModel: TConversationModel! {
        didSet {
            conversationAvatar.sd_setImageWithURL(conversationModel.conversationAvatar(), placeholderImage: nil)
            if conversationModel.isTopConversation() {
                conversationShowName.textColor = UIColor.cyanColor()

            }
            conversationShowName.text = conversationModel.conversationShowName()
            conversationMsgInfo.text = conversationModel.conversationMsgInfo()
            conversationLastUpdateTime.text = conversationModel.conversationLastUpdateTime()
            if  conversationModel.conversationUnreadCount() == nil {
                conversationUnreadCountLabel.hidden = true
            } else {
                conversationUnreadCountLabel.hidden = false
                conversationUnreadCountLabel.text = conversationModel.conversationUnreadCount()
            }
        
            conversationMsgInfo.textColor = conversationModel.conversationMsgInfoColor()
        }
    }
    
    override func setHighlighted(highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        conversationUnreadCountLabel.backgroundColor = UIColor.redColor()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        conversationUnreadCountLabel.backgroundColor = UIColor.redColor()
    }
}


