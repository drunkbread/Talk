//
//  TConversationModel.swift
//  Talk
//
//  Created by 杜洁鹏 on 16/8/15.
//  Copyright © 2016年 DW. All rights reserved.
//

import Foundation

@objc protocol TConversationModelDelegate {
    func conversationLastChatter() -> String
    func conversationShowName() -> String
    func conversationShowAvatar() -> String?
    func conversationLastTime() -> String?
    func conversationLastMsg() -> String?
}


class TConversationModel: NSObject, TConversationModelDelegate{
    
    var conversation:EMConversation!
    
    init(conversation: EMConversation!) {
        super.init()
        self.conversation = conversation
    }
    
    func conversationLastChatter() -> String {
        return conversation.chatter
    }
    
    func conversationShowName() -> String {
        return "showName"
    }
    
    func conversationShowAvatar() -> String? {
        return "showAvatar"
    }
    
    func conversationLastTime() -> String? {
        return "lastTime"
    }
    
    func conversationLastMsg() -> String? {
        return "lastMsg"
    }
}