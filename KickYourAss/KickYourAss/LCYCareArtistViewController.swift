//
//  LCYCareArtistViewController.swift
//  KickYourAss
//
//  Created by eagle on 15/2/10.
//  Copyright (c) 2015年 多思科技. All rights reserved.
//

import UIKit

class LCYCareArtistViewController: LCYCareBaseViewController {
    
    private var info = [CYMJUserListAtListData]()
    
    private var dataInfo = [CareInfo]()
    private class CareInfo {
        let info: CYMJUserListAtListData
        let distance: String
        init(info: CYMJUserListAtListData, distance: String?) {
            self.info = info
            self.distance = distance ?? "未知"
        }
    }

    
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
    
    override func reload() {
        if let userID = LCYCommon.sharedInstance.userInfo?.userID {
            let parameter = [
                "user_id": userID,
                "role": "2"
            ]
            LCYNetworking.sharedInstance.POST(
                Api: LCYNetworking.LCYApi.UserListAtList,
                parameters: parameter,
                success: {
                    [weak self](object) -> Void in
                    let retrieved = CYMJUserListAtListBase.modelObjectWithDictionary(object)
                    if retrieved.result == 1000 {
                        //                        self?.info.removeAll(keepCapacity: true)
                        //                        self?.info.extend(retrieved.data as [CYMJUserListAtListData])
                        self?.dataInfo.removeAll(keepCapacity: false)
                        //                        self?.dataInfo.extend(
                        //                            (retrieved.data as [CYMJUserListAtListData]).map(
                        //                                (CYMJUserListAtListData) -> CareInfo in
                        //                                let distanceString = self?.geoManager.distanceFrom(self?.location, toLatitude: $0.latitude.doubleValue, toLongitude: $0.longitude.doubleValue)
                        //                                return CareInfo(info: $0, distance: distanceString)
                        //                            )
                        //                        )
                        self?.dataInfo.extend(
                            (retrieved.data as [CYMJUserListAtListData]).map(
                                {
                                    let distanceString = self?.geoManager.distanceFrom(self?.location, toLatitude: $0.latitude.doubleValue, toLongitude: $0.longitude.doubleValue).toKM()
                                    return CareInfo(info: $0, distance: distanceString)
                                }
                            )
                        )
                        self?.tableView.reloadData()
                    } else {
                        self?.alertWithErrorCode(retrieved.result)
                    }
                    return
                }, fail: {
                    [weak self]() -> Void in
                    self?.alertNetworkFailed()
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
        let cell = tableView.dequeueReusableCellWithIdentifier(LCYCareArtistCell.identifier, forIndexPath: indexPath) as LCYCareArtistCell
        
        // Configure the cell...
        let data = dataInfo[indexPath.row].info
        cell.nickNameLabel.text = data.nickName
        cell.artworkCountLabel.text = "作品：" + data.albumCount
        cell.imagePath = data.headImage.toAbsoluteImagePath()
        cell.starCountLabel.text = data.byAttention
        cell.markCount = data.score.doubleValue
        cell.distanceLabel.text = dataInfo[indexPath.row].distance
        
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
