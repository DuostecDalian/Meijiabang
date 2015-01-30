//
//  ZXY_MostFashionVC.swift
//  KickYourAss
//
//  Created by 宇周 on 15/1/27.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

class ZXY_HomeMostFashionVC: UIViewController {

    @IBOutlet weak var backFreshView: UIView!
    @IBOutlet weak var currentCollectionV: UICollectionView!
    private var currentPage = 1
    var currentAlbumList = NSMutableArray()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var tap = UITapGestureRecognizer(target: self, action: Selector("backFreshAction"))
        tap.numberOfTapsRequired = 1
        backFreshView.userInteractionEnabled = true
        backFreshView.addGestureRecognizer(tap)
        
        currentCollectionV.addFooterWithCallback {[weak self] () -> Void in
            self?.currentCollectionV.footerPullToRefreshText = "上拉加载更多"
            self?.currentCollectionV.footerReleaseToRefreshText = "松开加载"
            self?.currentCollectionV.footerRefreshingText    = "正在加载"
            self?.currentPage++
            self?.startDownLoadData()
        }
        
        currentCollectionV.addHeaderWithCallback { [weak self] () -> Void in
            self?.currentPage = 1
            self?.currentCollectionV.headerPullToRefreshText = "下拉刷新"
            self?.currentCollectionV.headerReleaseToRefreshText = "松开刷新"
            self?.currentCollectionV.headerRefreshingText    = "正在刷新"
            self?.startDownLoadData()
        }
        
        self.startDownLoadData()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func backFreshAction() -> Void
    {
        currentPage = 1
        self.startDownLoadData()
    }
    
    func startDownLoadData() -> Void
    {
        
        var stringUrl = ZXY_ALLApi.ZXY_MainAPI + ZXY_ALLApi.ZXY_AlbumHotAPI
        var parameter = ["p": currentPage]
        
        ZXY_NetHelperOperate().startGetDataPost(stringUrl, parameter: parameter, successBlock: {[weak self] (returnDic) -> Void in
            
            var allReturnDic : ZXY_AlbumHotAlbumHot = ZXY_AlbumHotAlbumHot(dictionary: returnDic)
            
            if(self?.currentPage == 1)
            {
                self?.currentAlbumList.removeAllObjects()
                
                self?.currentAlbumList.addObjectsFromArray(allReturnDic.data)
            
            }
            else
            {
                self?.currentAlbumList.addObjectsFromArray(allReturnDic.data)
            }
            self?.reloadCurrentCollectionV()
            self?.currentCollectionV.footerEndRefreshing()
            self?.currentCollectionV.headerEndRefreshing()
            if(self?.currentAlbumList.count == 0 )
            {
                self?.currentCollectionV.hidden = true
            }
            else
            {
                self?.currentCollectionV.hidden = false
            }

            
        }) {[weak self] (error) -> Void in
            self?.currentCollectionV.footerEndRefreshing()
            self?.currentCollectionV.headerEndRefreshing()
            if(self?.currentAlbumList.count == 0 )
            {
                self?.currentCollectionV.hidden = true
            }

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

extension ZXY_HomeMostFashionVC: UICollectionViewDelegate , WaterfallLayoutDelegate , UICollectionViewDataSource
{
    func reloadCurrentCollectionV()
    {
        currentCollectionV.reloadData()
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentAlbumList.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        var currentRow = indexPath.row
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier(ZXY_HomeMostFashionCellID, forIndexPath: indexPath) as ZXY_HomeMostFashionCell
        var currentData : ZXY_AlbumHotData = currentAlbumList[currentRow] as ZXY_AlbumHotData
        
        cell.fashionValue.text = currentData.agreeCount
        cell.fashionTime.text  = self.timeStampToDateString(currentData.addTime)
        cell.fashionName.text  = currentData.dataDescription
        cell.artistName.text   = currentData.user.nickName
        
        var profileString : String? = ZXY_ALLApi.ZXY_MainAPIImage + currentData.user.headImage
        var artImage : String?      = ZXY_ALLApi.ZXY_MainAPIImage + currentData.image.cutPath
        if(currentData.user.headImage.hasPrefix("http"))
        {
            profileString = currentData.user.headImage
        }
        if(artImage != nil)
        {
            cell.setArtImage(NSURL(string: artImage!))
        }
        else
        {
            cell.setArtImage(nil)
        }
        
        if(profileString != nil)
        {
            cell.setHeaderImage(NSURL(string: profileString!))
        }
        else
        {
            cell.setHeaderImage(nil)
        }
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView!, layout collectionViewLayout: UICollectionViewLayout!, sizeForItemAtIndexPath indexPath: NSIndexPath!) -> CGSize {
        var currentRow = indexPath.row
        
        var currentData : ZXY_AlbumHotData = currentAlbumList[currentRow] as ZXY_AlbumHotData
        var width       = (currentData.image.cutWidth as NSString).floatValue
        var height      = (currentData.image.cutHeight as NSString).floatValue
        
        var radio       = height / width
        
        var screenWidths = self.view.frame.size.width / 2 - 10
        
        var imgRealHeight = CGFloat(radio) * screenWidths
        
        return CGSizeMake(screenWidths, imgRealHeight + 111)
    }
    
    func collectionView(collectionView: UICollectionView!, layout collectionViewLayout: UICollectionViewLayout!, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(5, 5, 5, 5)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        ZXY_AllColor().startRandomColor()
    }
}
