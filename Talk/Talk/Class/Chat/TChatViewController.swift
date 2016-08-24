//
//  TChatViewController.swift
//  Talk
//
//  Created by 杜洁鹏 on 16/8/18.
//  Copyright © 2016年 DW. All rights reserved.
//

import UIKit

class TChatViewController: UITableViewController {

    var conversationModel: TConversationModel!
    var datasource: Array<TMessageCellModel>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addEaseMobDelegate()
        tableView.rowHeight = UITableViewAutomaticDimension; 
        tableView.estimatedRowHeight = 40
        registerTableCell()
        loadMessages(10)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func registerTableCell() {
        tableView.registerNib(UINib(nibName: "TChatTextCell_Left", bundle: nil), forCellReuseIdentifier: "TChatTextCell_Left")
        tableView.registerNib(UINib(nibName: "TChatTextCell_Right", bundle: nil), forCellReuseIdentifier: "TChatTextCell_Right")
    }

    /*
    // MARK: - Navigation
     

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource?.count ?? 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TChatTextCell_Left") as! TChatTextCell
        cell.model = datasource![indexPath.row]
        return cell
    }
}

extension TChatViewController {
    func loadMessages(count: UInt) {
        if datasource == nil {
            datasource = Array()
        }
        let msgId = datasource!.last?.messageId()
        let messages = conversationModel.conversationLoadMessage(count, msgId: msgId)
        for message in messages {
            let msgModel = TMessageCellModel(message: message as! EMMessage)
            datasource?.append(msgModel)
        }
        
        tableView.reloadData()
    }
    
    func addMessageToDatasource(message: EMMessage) {
        if datasource == nil {
            datasource = Array()
        }
        datasource?.append(TMessageCellModel(message:message))
        tableView.beginUpdates()
        tableView.insertRowsAtIndexPaths([NSIndexPath(forItem: datasource!.count - 1 , inSection: 0)], withRowAnimation: UITableViewRowAnimation.Fade)
        tableView.endUpdates()
        scrollsToBottomAnimated(true)
    }
    
    func scrollsToBottomAnimated(animated: Bool) {
        tableView.scrollToRowAtIndexPath(NSIndexPath(forItem: datasource!.count - 1, inSection: 0),
                                         atScrollPosition: UITableViewScrollPosition.Bottom,
                                         animated: animated)
    }
}

extension TChatViewController: IChatManagerDelegate {
    
    func addEaseMobDelegate() {
        chatManager.addDelegate(self, delegateQueue: nil)
    }
    
    func didReceiveMessage(message: EMMessage!) {
        addMessageToDatasource(message)
    }
}
