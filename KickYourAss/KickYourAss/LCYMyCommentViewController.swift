//
//  LCYMyCommentViewController.swift
//  KickYourAss
//
//  Created by eagle on 15/2/11.
//  Copyright (c) 2015年 多思科技. All rights reserved.
//

import UIKit

class LCYMyCommentViewController: UITableViewController {
    
    private var dataInfo = [CYMJUserListOrderEvaData]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        tableView.hideExtraSeprator = true
        reload()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func reload() {
        let parameter = [
            "user_id": LCYCommon.sharedInstance.userInfo!.userID,
            "p": "1"
        ]
        LCYNetworking.sharedInstance.POST(
            Api: LCYNetworking.LCYApi.UserListOrderEva,
            parameters: parameter,
            success: { [weak self](object) -> Void in
                let retrieved = CYMJUserListOrderEvaBase.modelObjectWithDictionary(object)
                if retrieved.result == 1000 {
                    self?.dataInfo.removeAll(keepCapacity: false)
                    self?.dataInfo.extend(retrieved.data as [CYMJUserListOrderEvaData])
                    self?.tableView.reloadData()
                } else {
                    self?.alertWithErrorCode(retrieved.result)
                }
                return
            }) { [weak self]() -> Void in
                self?.alertNetworkFailed()
                return
        }
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return dataInfo.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(LCYMyCommentTableViewCell.identifier, forIndexPath: indexPath) as LCYMyCommentTableViewCell

        // Configure the cell...
        let data = dataInfo[indexPath.row]
        cell.nickNameLabel.text = data.nickName
        cell.imagePath = data.headImage?.toAbsoluteImagePath()
        cell.markCount = data.score.doubleValue
        cell.contentLabel.text = data.comment
        cell.timeLabel.text = data.ctime.stringFromTimeStamp(format: "yyyy-MM-dd HH:mm:ss")
        
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
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
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
