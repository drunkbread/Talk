//
//  TContactsViewController.swift
//  Talk
//
//  Created by 杜洁鹏 on 16/8/12.
//  Copyright © 2016年 DW. All rights reserved.
//

class TContactsViewController: UITableViewController {
    
    var contacts: Array<AnyObject>?
    let firstPart = ["群组","聊天室","客服"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reloadContacts()
    }

    

    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 3
        } else {
            return contacts?.count ?? 0
        }
    }
    
     override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCellWithIdentifier("TContactCell", forIndexPath: indexPath) as! TContactCell
        if indexPath.section == 0 {
            cell.headImage = UIImage(named: "7")
            cell.contactName = firstPart[indexPath.row]
        } else {
            cell.headImage = UIImage(named: "123.jpg")
            cell.contactName = (contacts?[indexPath.row])!.username
        }
     return cell
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        } else {
            return 20
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }

}

extension TContactsViewController: IChatManagerDelegate {
    
    func reloadContacts() {
        if contacts == nil {
            contacts = Array()
        }
        let friends = chatManager.buddyList as NSArray
        let blocks = chatManager.blockedList as NSArray
        for buddy in friends {
            if !blocks.containsObject(buddy) {
                contacts?.append(buddy)
            }
        }
        let loginUser = chatManager.loginInfo["username"] as! String
        let selfBuddy = EMBuddy.init(username: loginUser)
        contacts?.append(selfBuddy)
        tableView.reloadData()
    }
}
