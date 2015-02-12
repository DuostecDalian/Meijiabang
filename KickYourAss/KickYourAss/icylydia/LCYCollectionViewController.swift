//
//  LCYCollectionViewController.swift
//  KickYourAss
//
//  Created by eagle on 15/2/12.
//  Copyright (c) 2015年 多思科技. All rights reserved.
//

import UIKit

class LCYCollectionViewController: UICollectionViewController {
    
    private var currentPage = 1
    
    private class InfoData {
        let data: CYMJAlbumMyCollectionData
        let color: UIColor
        init(data: CYMJAlbumMyCollectionData) {
            self.data = data
            color = UIColor.randomColor()
        }
    }
    private var infoData = [InfoData]()
    private let itemWidth = (UIScreen.mainScreen().bounds.width - 5.0 - 5.0 - 10.0) / 2.0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes

        // Do any additional setup after loading the view.
        
        collectionView?.addFooterWithCallback({ [weak self]() -> Void in
            self?.loadMore()
            return
        })
        collectionView?.addHeaderWithCallback({ [weak self]() -> Void in
            self?.reload()
            return
        })
        
        reload()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func reload() {
        currentPage = 1
        let parameter = [
            "user_id": LCYCommon.sharedInstance.userInfo!.userID,
            "p": "1"
        ]
        LCYNetworking.sharedInstance.POST(
            Api: LCYNetworking.LCYApi.AlbumMyCollect,
            parameters: parameter,
            success: {[weak self] (object) -> Void in
                let retrieved = CYMJAlbumMyCollectionBase.modelObjectWithDictionary(object)
                if retrieved.result == 1000 {
                    self?.infoData.removeAll(keepCapacity: false)
                    self?.infoData.extend(
                        (retrieved.data as [CYMJAlbumMyCollectionData]).map(
                            {
                                InfoData(data: $0)
                            }
                        )
                    )
                    self?.collectionView?.reloadData()
                } else {
                    self?.alertWithErrorCode(retrieved.result)
                }
                self?.collectionView?.headerEndRefreshing()
                return
            }, fail: {
                [weak self] in
                self?.collectionView?.headerEndRefreshing()
                self?.alertNetworkFailed()
                return
        })
    }
    
    func loadMore() {
        currentPage++
        let parameter = [
            "user_id": LCYCommon.sharedInstance.userInfo!.userID,
            "p": "\(currentPage)"
        ]
        LCYNetworking.sharedInstance.POST(
            Api: LCYNetworking.LCYApi.AlbumMyCollect,
            parameters: parameter,
            success: {[weak self] (object) -> Void in
                let retrieved = CYMJAlbumMyCollectionBase.modelObjectWithDictionary(object)
                if retrieved.result == 1000 {
                    self?.infoData.extend(
                        (retrieved.data as [CYMJAlbumMyCollectionData]).map(
                            {
                                InfoData(data: $0)
                            }
                        )
                    )
                    self?.collectionView?.reloadData()
                } else {
                    self?.alertWithErrorCode(retrieved.result)
                }
                self?.collectionView?.footerEndRefreshing()
                return
        }) { [weak self]() -> Void in
            self?.collectionView?.footerEndRefreshing()
            self?.alertNetworkFailed()
            return
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        return infoData.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(LCYCollectionCell.identifier, forIndexPath: indexPath) as LCYCollectionCell
    
        // Configure the cell
        let data = infoData[indexPath.row].data
        let color = infoData[indexPath.row].color
        cell.imagePath = data.cutPath?.toAbsoluteImagePath()
        cell.upNumberLabel.text = data.agreeCount
        cell.icyTimeLabel.text = data.addTime.stringFromTimeStamp(format: "yyyy-MM-dd")
        cell.contentLabel.text = data.dataDescription
        cell.avatarImagePath = data.headImage?.toAbsoluteImagePath()
        cell.authorNameLabel.text = data.nickName
        cell.lineColor = color
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}

extension LCYCollectionViewController: WaterfallLayoutDelegate {
    func collectionView(collectionView: UICollectionView!, layout collectionViewLayout: UICollectionViewLayout!, sizeForItemAtIndexPath indexPath: NSIndexPath!) -> CGSize {
        let data = infoData[indexPath.row].data
        let ratio = CGFloat(data.cutWidth.doubleValue / data.cutHeight.doubleValue)
        return CGSize(width: itemWidth, height: itemWidth / ratio + 113.0)
    }
    func collectionView(collectionView: UICollectionView!, layout collectionViewLayout: UICollectionViewLayout!, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0.0, left: 5.0, bottom: 5.0, right: 5.0)
    }
}
