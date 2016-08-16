//
//  EaseMobExtension.swift
//  Talk
//
//  Created by 杜洁鹏 on 16/8/16.
//  Copyright © 2016年 DW. All rights reserved.
//

extension EMMessage {
    func msgBodyType() -> MessageBodyType {
        let body = messageBodies.first as! IEMMessageBody
        return body.messageBodyType
    }
    
    func text() -> String {
        let body = messageBodies.first as! EMTextMessageBody
        return body.text
    }
}
