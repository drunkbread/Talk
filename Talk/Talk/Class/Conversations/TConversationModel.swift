//
//  TConversationModel.swift
//  Talk
//
//  Created by 杜洁鹏 on 16/8/15.
//  Copyright © 2016年 DW. All rights reserved.
//

import Foundation


protocol TConversationModelDelegate {
    
    // 会话显示的头像
    func conversationAvatar() -> NSURL?
    
    // 返回会话id
    func conversationChatter() -> String
    
    // 返回会话类型
    func conversationType() -> EMConversationType
    
    // 会话显示的名称
    func conversationShowName() -> String
    
    // 会话中最后一条消息的时间
    func conversationLastUpdateTime() -> String?
    
    // 会话中最后一条消息的内容
    func conversationMsgInfo() -> String?
    
    // 会话的未读消息数
    func conversationUnreadCount() -> String?
    
    // 最后一条消息的显示颜色 (如果是未读的音频，需要显示红色)
    func conversationMsgInfoColor() -> UIColor
    
    // load message
    func conversationLoadMessage(count: UInt, msgId: String?) -> Array<AnyObject>
    
    //是否为置顶会话
    func isTopConversation() -> Bool
    
}


class TConversationModel: NSObject, TConversationModelDelegate{
    
    var conversation:EMConversation!
    
    init(conversation: EMConversation!) {
        super.init()
        self.conversation = conversation
    }
    
    func conversationAvatar() -> NSURL? {
        return NSURL(string: "http://www.jf258.com/uploads/2013-07-07/070645591.jpg")
    }
    
    func isTopConversation() -> Bool {
//        if let ext = conversation.ext {
//            if ext["top"] != nil {
//                return true
//            } else {
//                return false
//            }
//        } else {
//            return false
//        }
        guard let ext = conversation.ext else {
            return false
        }
        if ext["top"] != nil {
            return true
        } else {
            return false
        }
    }
    
    func conversationShowName() -> String {
        // 如果有名字，这里要加上名字的判断
        return conversation.chatter
    }
    
    func conversationChatter() -> String{
        return conversation.chatter
    }
    
    func conversationType() -> EMConversationType {
        return conversation.conversationType
    }
    
    func conversationLastUpdateTime() -> String? {
        var dTime = Double(0)
        
        if let latestMsg = conversation.latestMessage() {
            dTime = Double(latestMsg.timestamp)
        } else {
            dTime = 0
        }
        
        return NSDate().UnixTimestampToString(dTime)
    }
    
    func conversationMsgInfo() -> String? {
        let ret: String!
        let msge = conversation.latestMessage()
        if let msg = msge {
        if msg.msgBodyType() != nil {
            switch msg.msgBodyType()! {
            case MessageBodyType.eMessageBodyType_Text :
                ret = msg.text()
            case MessageBodyType.eMessageBodyType_Image :
                ret = "[图片]"
            case MessageBodyType.eMessageBodyType_Video :
                ret = "[视频]"
            case MessageBodyType.eMessageBodyType_Voice :
                ret = "[音频]"
            case MessageBodyType.eMessageBodyType_Location :
                ret = "[位置]"
            case MessageBodyType.eMessageBodyType_File :
                ret = "[文件]"
            default:
                ret = ""
            }
        } else {
            ret = ""
        }
            return ret
        } else {
            return nil
        }
    }
    
    func conversationUnreadCount() -> String? {
        if conversation.unreadMessagesCount() > 0 && conversation.unreadMessagesCount() < 100{
            return String(conversation.unreadMessagesCount())
        } else if (conversation.unreadMessagesCount() >= 100) {
            return "N+"
        }else {
            return nil
        }
    }
    
    func conversationMsgInfoColor() -> UIColor {
        return UIColor.lightGrayColor()
    }
    
    func conversationLoadMessage(count: UInt, msgId: String?) -> Array<AnyObject> {
        return conversation.loadNumbersOfMessages(count, withMessageId: msgId)
    }
    
    func makeConversationAsRead() {
        conversation.markAllMessagesAsRead(true)
    }
    
    func makeConversationAsUnread() {
        conversation.markMessageWithId(conversation.latestMessage().messageId, asRead: false)
    }
    

    
    
}