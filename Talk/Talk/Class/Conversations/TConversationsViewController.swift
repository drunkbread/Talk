//
//  TConversationsViewController.swift
//  Talk
//
//  Created by 杜洁鹏 on 16/8/12.
//  Copyright © 2016年 DW. All rights reserved.
//

import UIKit

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
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }1
     */
    
}

// MARK - EaseMob
extension TConversationsViewController: EMChatManagerDelegate{
    func addEaseMobDelegate() {
        chatManager.addDelegate(self, delegateQueue: nil)
    }
    
    func loadAllConversations() {
        // 这个方法是从db里load conversations，后面传true，取到后就会走对应的回调（ didUpdateConversationList:）
        chatManager.loadAllConversationsFromDatabaseWithAppend2Chat!(true)
    }
    
    // 会话列表数量变更回调
    func didUpdateConversationList(conversationList: [AnyObject]!) {
        conversationsToModel(chatManager.conversations)
    }
    
    // 收消息回调
    func didReceiveMessage(message: EMMessage!) {
        conversationsToModel(chatManager.conversations)
    }
    
    func backwards(time1: Double, time2: Double) -> Bool {
        return time1 > time2
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
        if  ary != nil {
            for conversation in conversations! {
                if datasource == nil {
                    datasource = Array()
                }
                let c = conversation as! EMConversation
                datasource?.append(TConversationModel(conversation: c))
                unreadCount += c.unreadMessagesCount() ?? 0
            }
            
            tableView.reloadData()
            navigationController?.tabBarItem.badgeValue = String(unreadCount)
        } else {
            navigationController?.tabBarItem.badgeValue = nil
        }
    }
    
    func didAutoLoginWithInfo(loginInfo: [NSObject : AnyObject]!, error: EMError!) {
        print("error  --- \(error)" )
    }
}

