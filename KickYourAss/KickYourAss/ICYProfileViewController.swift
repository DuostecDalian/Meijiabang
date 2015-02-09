//
//  ICYProfileViewController.swift
//  KickYourAss
//
//  Created by eagle on 15/2/9.
//  Copyright (c) 2015年 多思科技. All rights reserved.
//

import UIKit

class ICYProfileViewController: UITableViewController {
    
    var userInfo: CYMJUserInfoData!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 3
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell!

        // Configure the cell...
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                cell = tableView.dequeueReusableCellWithIdentifier(ICYProfileAvatarCell.identifier) as UITableViewCell
                let cell = cell as ICYProfileAvatarCell
                cell.icyMainLabel.text = "头像"
                cell.imagePath = userInfo.headImage.toAbsoluteImagePath()
            case 1:
                cell = tableView.dequeueReusableCellWithIdentifier(ICYProfileCell.identifier) as UITableViewCell
                let cell = cell as ICYProfileCell
                cell.icyMainLabel.text = "昵称"
                cell.icyDetailLabel?.text = userInfo.nickName
            case 2:
                cell = tableView.dequeueReusableCellWithIdentifier(ICYProfileCell.identifier) as UITableViewCell
                let cell = cell as ICYProfileCell
                cell.icyMainLabel.text = "性别"
                var sex: String = userInfo.sex ?? "3"
                cell.icyDetailLabel.text = userInfo.sex == "1" ? "男" : userInfo.sex == "2" ? "女" : "未知"
            default:
                break
            }
        case 1:
            cell = tableView.dequeueReusableCellWithIdentifier(ICYProfileCell.identifier) as UITableViewCell
            let cell = cell as ICYProfileCell
            switch indexPath.row {
            case 0:
                cell.icyMainLabel.text = "注册电话"
                cell.icyDetailLabel.text = userInfo.tel.checkNull()
            case 1:
                cell.icyMainLabel.text = "真实姓名"
                cell.icyDetailLabel.text = userInfo.realName.checkNull()
            case 2:
                cell.icyMainLabel.text = "常用地址"
                cell.icyDetailLabel.text = userInfo.address.checkNull()
            default:
                break
            }
        default:
            break
        }

        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 && indexPath.row == 0 {
            return 60.0
        } else {
            return 44.0
        }
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
