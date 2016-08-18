//
//  TConversationsViewController.swift
//  Talk
//
//  Created by 杜洁鹏 on 16/8/12.
//  Copyright © 2016年 DW. All rights reserved.
//

import UIKit
import Async

class TConversationsViewController: UITableViewController{
    
    var datasource: Array<TConversationModel>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addEaseMobDelegate()
        loadAllConversations()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource?.count ?? 0
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TConversationCell", forIndexPath: indexPath) as! TConversationCell
        cell.conversationModel = datasource![indexPath.row]
        return cell
    }
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        //        let conversationModel = datasource?[indexPath.row]
        //        let str = conversationModel?.conversationUnreadCount() != nil ? "标为已读" : "标为未读"
        //        let action1 = UITableViewRowAction(style: UITableViewRowActionStyle.Normal, title: str, handler: { (action, index) in
        //            if conversationModel?.conversationUnreadCount() != nil {
        //                conversationModel!.makeConversationAsRead()
        //            } else {
        //                conversationModel!.makeConversationAsUnread()
        //            }
        //        })
        
        let action2 = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "删除", handler: { (action, index) in
            Async.main
                {
                    let conversationModel = self.datasource?.removeAtIndex(indexPath.row)
                    chatManager.removeConversationsByChatters!([(conversationModel?.conversationChatter())!], deleteMessages: true, append2Chat: true)
                    tableView.beginUpdates()
                    tableView.deleteRowsAtIndexPaths([index], withRowAnimation: UITableViewRowAnimation.None)
                    tableView.endUpdates()
                }.main(after:3) {
                    self.conversationsToModel(chatManager.conversations)
            }
        })
        
        return [action2]
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
     if editingStyle == .Delete {
     // Delete the row from the data source
     tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
     } else if editingStyle == .Insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
     // MARK: - Navigation
    
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if ((sender?.isKindOfClass(TConversationCell.classForCoder())) != nil)
            && segue.destinationViewController.isKindOfClass(TChatViewController.classForCoder()){
            let cell = sender as! TConversationCell
            let vc = segue.destinationViewController as! TChatViewController
            vc.chatter = cell.conversationModel.conversationChatter()
        }
     }
}

// MARK - EaseMob
extension TConversationsViewController: EMChatManagerDelegate{
    func addEaseMobDelegate() {
        chatManager.addDelegate(self, delegateQueue: nil)
    }
    
    func loadAllConversations() {
        // 这个方法是从db里load conversations，后面传true，取到后就会走对应的回调（ didUpdateConversationList:）
        chatManager.loadAllConversationsFromDatabaseWithAppend2Chat!(true)
        conversationsToModel(chatManager.conversations)
    }
    
    // 会话列表数量变更回调
    func didUpdateConversationList(conversationList: [AnyObject]!) {
        //        conversationsToModel(chatManager.conversations)
    }
    
    // 消息的未读数变化
    func didUnreadMessagesCountChanged() {
        //        conversationsToModel(chatManager.conversations)
    }
    
    // 收消息回调
    func didReceiveMessage(message: EMMessage!) {
        conversationsToModel(chatManager.conversations)
    }
    
    func conversationsToModel( ary: Array <AnyObject>?) {
        datasource?.removeAll()
        let conversations = ary?.sort(
            { conversation1 , conversation2 in
                let c1 = conversation1 as! EMConversation
                let c2 = conversation2 as! EMConversation
                return c1.latestMessage()?.timestamp ?? 0 >= c2.latestMessage()?.timestamp ?? 0
            }
        )
        
        var unreadCount: UInt = 0
        
        for conversation in conversations! {
            if datasource == nil {
                datasource = Array()
            }
            let c = conversation as! EMConversation
            datasource?.append(TConversationModel(conversation: c))
            unreadCount += c.unreadMessagesCount() ?? 0
        }
        
        tableView.reloadData()
        if unreadCount > 0 {
            navigationController?.tabBarItem.badgeValue = String(unreadCount)
        } else {
            navigationController?.tabBarItem.badgeValue = nil
        }
        
    }
    
    func didAutoLoginWithInfo(loginInfo: [NSObject : AnyObject]!, error: EMError!) {
        print("error  --- \(error)" )
    }
}

