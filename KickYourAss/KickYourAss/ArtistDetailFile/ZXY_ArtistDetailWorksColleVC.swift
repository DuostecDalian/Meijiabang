//
//  ZXY_ArtistDetailWorksColleVC.swift
//  KickYourAss
//
//  Created by 宇周 on 15/1/29.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit
let ZXY_ArtistDetailWorksColleVCID = "artistWorkID"
protocol ZXY_ArtistDetailWorksColleVCDelegate : class , NSObjectProtocol
{
    func collectionViewDidScroll(collection: UICollectionView)
    func noDataDownCollection()
    func clickItem(albumID : String )
    //func clickItemAt
}

class ZXY_ArtistDetailWorksColleVC: UIViewController {

    @IBOutlet weak var noNetLbl: UILabel!
    
    @IBOutlet weak var noNetView: UIView!
    
    private var userID : String!
    private var currentPage : Int = 1
    private var isDownLoad = false
    private var dataForShow : NSMutableArray = NSMutableArray()
    weak var delegate : ZXY_ArtistDetailWorksColleVCDelegate?
    
    @IBOutlet weak var currentCollection: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        var tapReload = UITapGestureRecognizer(target: self, action: Selector("startDownLoadAlbum"))
        self.noNetView.addGestureRecognizer(tapReload)
        self.noNetView.userInteractionEnabled = true
        
        self.startDownLoadAlbum()
        
        currentCollection.addFooterWithCallback {[weak self] () -> Void in
            self?.currentCollection.footerPullToRefreshText = "上拉加载更多"
            self?.currentCollection.footerReleaseToRefreshText = "松开加载"
            self?.currentCollection.footerRefreshingText    = "正在加载"
            self?.currentPage++
            self?.startDownLoadAlbum()
        }
        


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setCurrentUserID(userID : String)
    {
        self.userID = userID
    }
    
    func startDownLoadAlbum()
    {
        if(isDownLoad)
        {
            return
        }
        isDownLoad = true
        var urlString = ZXY_ALLApi.ZXY_MainAPI + ZXY_ALLApi.ZXY_UserAlbumAPI
        ZXY_NetHelperOperate().startGetDataPost(urlString, parameter: ["user_id" : self.userID , "p" : currentPage], successBlock: { [weak self](returnDic) -> Void in
            var arr = ZXY_UserAlbumListBase(dictionary: returnDic).data
            if(self?.currentPage == 1)
            {
                    self?.dataForShow.removeAllObjects()
                    self?.dataForShow.addObjectsFromArray(arr)
            }
            else
            {
                self?.dataForShow.addObjectsFromArray(arr)
            }
            self?.reloadCurrentCollection()
            }) {[weak self] (error) -> Void in
                self?.reloadCurrentCollection()
                println(error)
        }

    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ZXY_ArtistDetailWorksColleVC : UICollectionViewDelegate , UICollectionViewDataSource , WaterfallLayoutDelegate , UIScrollViewDelegate
{
    func reloadCurrentCollection()
    {
        isDownLoad = false
        if(!AFNetworkReachabilityManager.sharedManager().reachable)
        {
            self.noNetLbl.text = "网络不给力，查看下吧！请点击页面重试"
        }
        else
        {
            self.noNetLbl.text = "   未获取到内容    请点击页面重试"
        }
        if(dataForShow.count == 0)
        {
            currentCollection.backgroundColor = UIColor.clearColor()
        }
        else
        {
            currentCollection.backgroundColor = UIColor.whiteColor()
        }
        self.currentCollection.reloadData()
        currentCollection.footerEndRefreshing()
        currentCollection.headerEndRefreshing()
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataForShow.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        var currentRow = indexPath.row
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier(ZXY_HomeMostFashionCellID, forIndexPath: indexPath) as ZXY_HomeMostFashionCell
        var currentData : ZXY_UserAlbumListData = dataForShow[currentRow] as ZXY_UserAlbumListData
        
        cell.fashionValue.text = currentData.agreeCount
        cell.fashionTime.text  = self.timeStampToDateString(currentData.addTime)
        cell.fashionName.text  = currentData.dataDescription
        var artImage : String?      = ZXY_ALLApi.ZXY_MainAPIImage + currentData.cutPath
        if(artImage != nil)
        {
            cell.setArtImage(NSURL(string: artImage!))
        }
        else
        {
            cell.setArtImage(nil)
        }
        
        cell.edgeImage.layer.cornerRadius = 5
        cell.edgeImage.layer.masksToBounds = true
        
        cell.edgeImage.backgroundColor = ZXY_AllColor().startRandomColor()
        return cell
    }
    
    func collectionView(collectionView: UICollectionView!, layout collectionViewLayout: UICollectionViewLayout!, sizeForItemAtIndexPath indexPath: NSIndexPath!) -> CGSize {
        var currentRow = indexPath.row
        
        var currentData : ZXY_UserAlbumListData = dataForShow[currentRow] as ZXY_UserAlbumListData
        var width       = (currentData.cutWidth as NSString).floatValue
        var height      = (currentData.cutHeight as NSString).floatValue
        
        var radio       = height / width

        var screenWidths = self.view.frame.size.width / 2 - 10
        
        var imgRealHeight = CGFloat(radio) * screenWidths
        
        return CGSizeMake(screenWidths, imgRealHeight + 70)
    }
    
    func collectionView(collectionView: UICollectionView!, layout collectionViewLayout: UICollectionViewLayout!, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(5, 5, 5, 5)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        var currentData : ZXY_UserAlbumListData = dataForShow[indexPath.row] as ZXY_UserAlbumListData
        self.delegate?.clickItem(currentData.albumId)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if(self.delegate != nil)
        {
            self.delegate!.collectionViewDidScroll(currentCollection)
        }
    }

}
