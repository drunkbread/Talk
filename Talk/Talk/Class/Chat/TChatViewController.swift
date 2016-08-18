//
//  TChatViewController.swift
//  Talk
//
//  Created by 杜洁鹏 on 16/8/18.
//  Copyright © 2016年 DW. All rights reserved.
//

import UIKit

class TChatViewController: UITableViewController {

    var chatter: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(chatter)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        return 3
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TChatCell") as! TChatCell
        return cell
    }
}
