//
//  LCYOrderToMeViewController.swift
//  KickYourAss
//
//  Created by eagle on 15/2/11.
//  Copyright (c) 2015年 多思科技. All rights reserved.
//

import UIKit

class LCYOrderToMeViewController: LCYOrderBaseViewController {
    private var dataInfo = [CYMJOrderListData]()
    
    override func reload() {
        let parameter = [
            "user_id": LCYCommon.sharedInstance.userInfo!.userID,
            "role": LCYCommon.sharedInstance.userInfo!.role,
            "p": "1"
        ]
        LCYNetworking.sharedInstance.POST(
            Api: LCYNetworking.LCYApi.OrderList,
            parameters: parameter,
            success: { [weak self](object) -> Void in
                let retrieved = CYMJOrderListBase.modelObjectWithDictionary(object)
                if retrieved.result == 1000 {
                    self?.dataInfo.removeAll(keepCapacity: false)
                    self?.dataInfo.extend(retrieved.data as [CYMJOrderListData])
                    self?.tableView.reloadData()
                } else {
                    self?.alertWithErrorCode(retrieved.result)
                }
                return
            },
            { [weak self]() -> Void in
                self?.alertNetworkFailed()
                return
        })
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataInfo.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(LCYOrderFromMeCell.identifier) as LCYOrderFromMeCell
        let data = dataInfo[indexPath.row]
        cell.apTimeLabel.text = data.addTime.stringFromTimeStamp(format: "yyyy-MM-dd HH:mm:ss")
        cell.cusNameLabel.text = data.nickName
        cell.apLocationLabel.text = data.detailAddr
        cell.statusLabel.text = LCYCommon.sharedInstance.orderStatus(data.orderStatus)
        cell.showNew = data.orderStatus == "1"
        return cell
    }
}
