//
//  LCYCareNormalViewController.swift
//  KickYourAss
//
//  Created by eagle on 15/2/10.
//  Copyright (c) 2015年 多思科技. All rights reserved.
//

import UIKit

class LCYCareNormalViewController: LCYCareBaseViewController {
    
    private var dataInfo = [CYMJUserListAtListData]()

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
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    // MARK: - Action
    override func reload() {
        if let userID = LCYCommon.sharedInstance.userInfo?.userID {
            let parameter = [
                "user_id": userID,
                "role": "1"
            ]
            LCYNetworking.sharedInstance.POST(
                Api: LCYNetworking.LCYApi.UserListAtList,
                parameters: parameter,
                success: { [weak self](object) -> Void in
                    let retrieved = CYMJUserListAtListBase.modelObjectWithDictionary(object)
                    if retrieved.result == 1000 {
                        self?.dataInfo.extend(retrieved.data as [CYMJUserListAtListData])
                        self?.tableView.reloadData()
                    } else {
                        self?.alertWithErrorCode(retrieved.result)
                    }
                    return
            },
                fail: { () -> Void in
                return
            })
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
        let cell = tableView.dequeueReusableCellWithIdentifier(LCYCareNormalCell.identifier, forIndexPath: indexPath) as LCYCareNormalCell

        // Configure the cell...
        let data = dataInfo[indexPath.row]
        cell.nickNameLabel.text = data.nickName
        cell.albumLabel.text = "图集" + data.albumCount
        cell.careLabel.text = "关注" + data.byAttention
        cell.completedOrder.text = "完成订单" + data.orderCount2
        cell.markCount = data.score.doubleValue
        cell.imagePath = data.headImage.toAbsoluteImagePath()

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
