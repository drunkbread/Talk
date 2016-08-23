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
//        tableView.tableFooterView = UIView()
        registerTableCell()
        loadMessages(10)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func registerTableCell() {
        tableView.registerClass(TChatTextCell.classForCoder(), forCellReuseIdentifier: "TChatTextCell_Right")
        tableView.registerClass(TChatTextCell.classForCoder(), forCellReuseIdentifier: "TChatTextCell_Left")
        tableView.registerClass(TChatImageCell.classForCoder(), forCellReuseIdentifier: "TChatImageCell_Right")
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
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return (datasource![indexPath.row] as TMessageCellModel).messageCellHeight()
    }
}

extension TChatViewController {
    func loadMessages(count: UInt) {
        if datasource == nil {
            datasource = Array()
        }
        let msgId = datasource!.last?.messageId()
        let messages = conversationModel.conversation .loadNumbersOfMessages(count, withMessageId: msgId) as Array
        for message in messages {
            let msgModel = TMessageCellModel(message: message as! EMMessage)
            datasource?.append(msgModel)
        }
        
        tableView.reloadData()
    }
}