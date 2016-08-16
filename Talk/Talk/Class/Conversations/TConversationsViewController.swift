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
        chatManager.loadAllConversationsFromDatabaseWithAppend2Chat!(true)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
//        let txt = EMChatText(text: "test")
//        let body = EMTextMessageBody(chatObject: txt)
//        let msg = EMMessage.init(receiver: "du003", bodies: [body])
//        chatManager.asyncSendMessage(msg, progress: nil, prepare: { (message, error) in
//                print(error)
//            }, onQueue: nil, completion: { (message, error) in
//                print(error)
//            }, onQueue: nil)
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
    
    func didUpdateConversationList(conversationList: [AnyObject]!) {
        conversationsToModel(chatManager.conversations)
    }
    
    func didReceiveMessage(message: EMMessage!) {
        conversationsToModel(chatManager.conversations)
    }
    
    func conversationsToModel(ary: Array <AnyObject>?) {
        datasource?.removeAll()
        if  ary != nil {
            for conversation in ary! {
                if datasource == nil {
                    datasource = Array()
                }
                datasource?.append(TConversationModel(conversation: conversation as! EMConversation))
            }
            
            tableView.reloadData()
        }
    }
    
    func didAutoLoginWithInfo(loginInfo: [NSObject : AnyObject]!, error: EMError!) {
        print("error  --- \(error)" )
    }
}

