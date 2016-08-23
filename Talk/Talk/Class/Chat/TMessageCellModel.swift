//
//  TMessageModel.swift
//  Talk
//
//  Created by 杜洁鹏 on 16/8/22.
//  Copyright © 2016年 DW. All rights reserved.
//

import UIKit

protocol TMessageCellModelDelegate {
    
    func messageAvatar() -> NSURL?
    
    func messageChatter() -> String
    
    func messageType() -> EMMessageType
    
    func messageShowName() -> String
    
    func messageTime() -> Double
    
    func messageTextContent() -> String
    
    func messageId() -> String
    
    func messageCellHeight() -> CGFloat

}

class TMessageCellModel: NSObject{
    var message: EMMessage
    init(message: EMMessage!) {
        self.message = message
    }
}

extension TMessageCellModel: TMessageCellModelDelegate{
    
    func messageAvatar() -> NSURL? {
        return NSURL(string: "http://www.jf258.com/uploads/2013-07-07/070645591.jpg")
    }
    
    func messageChatter() -> String {
        return message.to
    }
    
    func messageType() -> EMMessageType {
        return message.messageType
    }
    
    func messageShowName() -> String {
        return message.from
    }
    
    func messageTime() -> Double {
        return Double(message.timestamp)
    }
    
    func messageTextContent() -> String {
        return "aaaaaa"
    }
    
    func messageId() -> String {
        return message.messageId
    }
    
    func messageCellHeight() -> CGFloat {
        return 60
    }
}
