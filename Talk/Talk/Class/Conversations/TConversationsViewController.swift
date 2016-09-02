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
    #if ShowSearch
    var filterArray: Array<TConversationModel>?
    var searchController: UISearchController!
    var shouldShowSearchResults = false
    #endif

    override func viewDidLoad() {
        super.viewDidLoad()
        #if ShowSearch
        configSearchController()
        #endif
        addEaseMobDelegate()
        loadAllConversations()
        addLogoutButton()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        #if ShowSearch
        if shouldShowSearchResults {
            return filterArray?.count ?? 0
        } else {
            return datasource?.count ?? 0
        }
        #else
        return datasource?.count ?? 0
        #endif
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TConversationCell", forIndexPath: indexPath) as! TConversationCell
        #if ShowSearch
        if shouldShowSearchResults {
            cell.conversationModel = filterArray?[indexPath.row]
        } else {
            cell.conversationModel = datasource![indexPath.row]
        }
        #else
        cell.conversationModel = datasource![indexPath.row]
        #endif
        return cell
    }
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {

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
            vc.conversationModel = cell.conversationModel
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
                conversationsToModel(chatManager.conversations)
    }
    
    // 消息的未读数变化
    func didUnreadMessagesCountChanged() {
                conversationsToModel(chatManager.conversations)
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
        if error == nil {
            chatManager.loadDataFromDatabase()
            chatManager.asyncFetchMyGroupsList()
            chatManager.asyncFetchBuddyList()
        } else {
            self.showRemindAlert("自动登录", info: "失败：\(error.description)")
        }
    }
}

extension TConversationsViewController {
    
    //MARK: - LF_Insert
    //添加退出按钮 * 测试用
    private func addLogoutButton() {
        let button = UIButton.init(frame: CGRectMake(0, 0, 44, 44))
        button.setTitle("退出", forState: UIControlState.Normal)
        button.titleLabel?.font = UIFont.systemFontOfSize(15.0)
        button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        button.addTarget(self, action: #selector(TConversationsViewController.logout), forControlEvents: UIControlEvents.TouchUpInside)
        let rightItem = UIBarButtonItem.init(customView: button)
        self.navigationItem.rightBarButtonItem = rightItem
    }
    
    @objc private func logout() {
        chatManager.asyncLogoffWithUnbindDeviceToken(true, completion: { (info, error) in
            if error == nil {
                NSNotificationCenter.defaultCenter().postNotificationName(ChangeMainViewController, object: nil)
            } else {
                self.showRemindAlert("退出登录", info: "退出登录：\(error.description)")
            }
            
            }, onQueue: nil)
    }
}

#if ShowSearch

extension TConversationsViewController: UISearchBarDelegate,UISearchResultsUpdating
{
    //MARK: - 初始化SearchController
    func configSearchController() {
        searchController = UISearchController.init(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        //搜索的时候背景变暗
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search here.."
        searchController.searchBar.delegate = self
        searchController.searchBar.sizeToFit()
        tableView.tableHeaderView = searchController.searchBar
    }
    
    //MARK: - UISearchBarDelegate
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        
        shouldShowSearchResults = true
        
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        shouldShowSearchResults = false
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        if !shouldShowSearchResults {
            shouldShowSearchResults = true
            tableView.reloadData()
        }
        searchController.searchBar.resignFirstResponder()
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        shouldShowSearchResults = false
        tableView.reloadData()
    }
    
    //MARK: - UISearchResultsUpdating
    
    func updateSearchResultsForSearchController(searchController: UISearchController)
    {
        let searchString = searchController.searchBar.text
        
        filterArray = datasource?.filter({ (country) -> Bool in
            
            let countryString: NSString = country.conversationChatter()
            return (countryString.rangeOfString(searchString!, options: NSStringCompareOptions.CaseInsensitiveSearch)).location != NSNotFound
            
        })
        tableView.reloadData()
    }
}

#endif
