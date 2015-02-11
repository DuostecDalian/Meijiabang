//
//  ZXY_ArtistDetailVC.swift
//  KickYourAss
//
//  Created by 宇周 on 15/1/29.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit
let ZXY_ArtistDetailVCID = "ZXY_ArtistDetailVCID"
class ZXY_ArtistDetailVC: UIViewController {
    
    @IBOutlet weak var evaluateView: UIView!
    
    @IBOutlet var rateItem: [UIImageView]!
    
    @IBOutlet weak var isAttenBtn: UIButton!
    
    @IBOutlet weak var currentTool: UIToolbar!
    
    
    @IBOutlet weak var heightOfTab: NSLayoutConstraint!
    
    
    
    @IBOutlet weak var titleImageView: UIView!
    
    @IBOutlet weak var headerImg: UIImageView!
    
    @IBOutlet weak var isArtistLbl: UILabel!
    
    @IBOutlet weak var backHeaderImg: UIImageView!
    
    
    
    @IBOutlet weak var numOfPay: UILabel!
    
    @IBOutlet weak var numOfComplete: UILabel!
    
    @IBOutlet weak var numOfAlbum: UILabel!
    
    private var maxToTop: CGFloat = 160
    
    /// seg
    @IBOutlet weak var filterSeg: UISegmentedControl!
    
    /// scroll Big
    @IBOutlet weak var currentScroll: UIScrollView!
    
    /// the view top of scroll Big
    @IBOutlet weak var currentTitleView: UIView!
    
    /// top constraints
    @IBOutlet weak var toTopConstraint: NSLayoutConstraint!
    
    /// tap of previous
    private var previousPoint : CGPoint = CGPointMake(0, 0)
    
    /// collectionV
    private var artCollection : ZXY_ArtistDetailWorksColleVC?
    
    /// tableV
    private var artComment    : ZXY_ArtistCommentTabVC?
    
    private var userID        : String!
    
    private var currentUser   : ZXY_ArtDetailInfoData?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.startInitSeg()
        self.headerImg.layer.cornerRadius = CGRectGetWidth(self.headerImg.frame) / 2
        self.backHeaderImg.layer.cornerRadius = CGRectGetWidth(self.headerImg.frame) / 2
        self.isArtistLbl.layer.cornerRadius   = CGRectGetWidth(self.isArtistLbl.layer.frame) / 2
        self.headerImg.layer.masksToBounds = true
        self.backHeaderImg.layer.masksToBounds = true
        self.isArtistLbl.layer.masksToBounds   = true
        
        
        self.startDownLoadDataList()
        // Do any additional setup after loading the view.
    }
    

    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        currentScroll.contentSize = CGSizeMake(self.view.frame.size.width * 2, currentScroll.frame.size.height)
        if(artCollection == nil)
        {
            var story  = UIStoryboard(name: "ArtistDetailStoryBoard", bundle: nil)
            
            artCollection = story.instantiateViewControllerWithIdentifier(ZXY_ArtistDetailWorksColleVCID) as? ZXY_ArtistDetailWorksColleVC
            artComment    = story.instantiateViewControllerWithIdentifier(ZXY_ArtistCommentTabVCID) as? ZXY_ArtistCommentTabVC
            
            
            artCollection?.setCurrentUserID(userID)
            artCollection?.delegate = self
            artComment?.delegate    = self
            artComment?.setCurrentUserID(userID)
            self.addChildViewController(artCollection!)
            self.addChildViewController(artComment!)
            
            artCollection?.view.frame = CGRectMake(0, 0, currentScroll.frame.size.width, currentScroll.frame.size.height)
            artComment?.view.frame = CGRectMake(currentScroll.frame.size.width, 0, currentScroll.frame.size.width, currentScroll.frame.size.height)
            
            currentScroll.addSubview(artCollection!.view)
            currentScroll.addSubview(artComment!.view)
        }
        self.setDownSuccessView()

    }
    
    func setUserID(userID : NSString )
    {
        self.userID = userID
    }
    
    // MARK: 初始化 seg
    func startInitSeg()
    {
        filterSeg.selectedSegmentIndex = 0
        //filterSeg.frame = CGRectMake(0, filterSeg.frame.origin.y, filterSeg.frame.size.width, filterSeg.frame.size.height)
        filterSeg.setTitle("Ta的图集", forSegmentAtIndex: 0)
        filterSeg.setTitle("订单评价", forSegmentAtIndex: 1)
        filterSeg.setTitleTextAttributes([NSForegroundColorAttributeName : ZXY_AllColor.SEARCH_RED_COLOR], forState: UIControlState.Selected)
        filterSeg.setTitleTextAttributes([NSForegroundColorAttributeName : ZXY_AllColor.VERTICAL_GRAY_COLOR], forState: UIControlState.Normal)
        
        filterSeg.setDividerImage(UIImage(named: "verticalGray"), forLeftSegmentState: UIControlState.Normal, rightSegmentState: UIControlState.Selected, barMetrics: UIBarMetrics.Default)
        
        filterSeg.setDividerImage(UIImage(named: "verticalGray"), forLeftSegmentState: UIControlState.Selected, rightSegmentState: UIControlState.Normal, barMetrics: UIBarMetrics.Default)
        
        filterSeg.setBackgroundImage(UIImage(named: "segBarSelect"), forState: UIControlState.Selected, barMetrics: UIBarMetrics.Default)
        filterSeg.setBackgroundImage(UIImage(named: "segBarNoSelect"), forState: UIControlState.Normal, barMetrics: UIBarMetrics.Default)
        
        filterSeg.addTarget(self, action: Selector("segPageChange:"), forControlEvents: UIControlEvents.ValueChanged)
        
    
    }

    /**
    开始下载数据
    */
    func startDownLoadDataList()
    {
        var stringURL = ZXY_ALLApi.ZXY_MainAPI + ZXY_ALLApi.ZXY_UserInfoAPI
        var myUserID : String? = LCYCommon.sharedInstance.userInfo?.userID
        if(myUserID == nil)
        {
            myUserID = ""
        }
        var parameter = ["user_id": userID , "my_user_id" : myUserID]
        
        ZXY_NetHelperOperate().startGetDataPost(stringURL, parameter: parameter, successBlock: { [weak self](returnDic) -> Void in
            self?.currentUser = ZXY_ArtDetailInfoBase(dictionary: returnDic).data
            self?.title = self?.currentUser?.nickName
            self?.setDownSuccessView()
            print("")
        }) { (error) -> Void in
            print(error)
        }
    }
    
    func setDownSuccessView()
    {
        if(currentUser != nil)
        {
            var imgStringURL = ZXY_ALLApi.ZXY_MainAPIImage + currentUser!.headImage
            if(currentUser!.headImage.hasPrefix("http"))
            {
                imgStringURL = currentUser!.headImage
            }
            self.headerImg.setImageWithURL(NSURL(string: imgStringURL))
            if(currentUser?.role == "2")
            {
                self.isArtistLbl.hidden = false
                self.numOfAlbum.text    = currentUser?.albumCount
                self.numOfPay.text      = currentUser?.byAttention
                self.numOfComplete.text      = currentUser?.orderCount2
            }
            else
            {
                self.isArtistLbl.hidden = true
                self.numOfAlbum.text    = currentUser?.albumCount
                self.numOfPay.text      = currentUser?.attention
                self.numOfComplete.text      = currentUser?.orderCount
            }
            if(currentUser?.isAttention == 1)
            {
                isAttenBtn.setImage(UIImage(named: "artistPay_down"), forState: UIControlState.Normal)
                isAttenBtn.setImage(UIImage(named: "artistPay_down"), forState: UIControlState.Highlighted)
                
            }
            else
            {
                isAttenBtn.setImage(UIImage(named: "artistPay_up"), forState: UIControlState.Normal)
                isAttenBtn.setImage(UIImage(named: "artistPay_up"), forState: UIControlState.Highlighted)
            }
            
            if(currentUser?.role! == "1")
            {
                self.heightOfTab.constant = 0
                self.currentTool.hidden = true
            }
            
            var tempValue = (currentUser!.score as NSString).integerValue
            if(tempValue >= rateItem.count)
            {
                tempValue = rateItem.count
            }
            for var i = 0 ; i < self.rateItem.count ; i++
            {
                if(i < tempValue)
                {
                    
                    var currentImgV = self.rateItem[i]
                    currentImgV.image = UIImage(named: "nailartistWhite_down")
                }
                else
                {
                    var currentImgV = self.rateItem[i]
                    currentImgV.image = UIImage(named: "nailartistWhite_up")
                }
            }
            

        }
    }
    
//    override func viewWillAppear(animated: Bool) {
//        super.viewWillAppear(animated)
//        self.tabBarController?.hidesBottomBarWhenPushed = true
//        
//    }
//    
//    override func viewWillDisappear(animated: Bool) {
//        super.viewWillDisappear(animated)
//        self.tabBarController?.hidesBottomBarWhenPushed = false
//    }
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

}


/**
*  相关滑动的代理 以及 seg控件的事件
*/
// MARK:相关滑动的代理 以及 seg控件的事件
extension ZXY_ArtistDetailVC : UIScrollViewDelegate , ZXY_ArtistCommentTabVCDelegate , ZXY_ArtistDetailWorksColleVCDelegate
{
    func scrollViewDidScroll(scrollView: UIScrollView) {
        var contentOffY : CGFloat = scrollView.contentOffset.y
        toTopConstraint.constant -= contentOffY
        if(toTopConstraint.constant < -maxToTop)
        {
            toTopConstraint.constant = -maxToTop
        }
        else if(toTopConstraint.constant > 0)
        {
            toTopConstraint.constant = 0
        }
        else
        {
            //tableConsYToHeader.constant = contentOffY
            scrollView.contentOffset.y = 0
        }

    }
    
    func clickItem(albumID: String) {
        var story = UIStoryboard(name: "ArtistDetailStoryBoard", bundle: nil)
        var vc    = story.instantiateViewControllerWithIdentifier("nailPictureID") as ZXY_NailPictureVC
        if(currentUser == nil)
        {
            vc.setAlbumID(albumID, user_id: "")
        }
        else
        {
            vc.setAlbumID(albumID, user_id: "", currentUser: currentUser!)
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionViewDidScroll(collection: UICollectionView) {
        self.scrollViewDidScroll(collection)
    }
    
    func noDataDownCollection()
    {
    
    }
    
    func noDataDownTable()
    {
        
    }
    
    func tableViewDidScroll(collection: UITableView) {
        self.scrollViewDidScroll(collection)
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        var touch : UITouch = touches.anyObject() as UITouch
        var point  : CGPoint  = touch.locationInView(self.view)
        var currentY = point.y
        var previousY = previousPoint.y
        if(CGRectContainsPoint(currentTitleView.frame, point))
        {
            if(abs(currentY - previousY) > 5)
            {
                previousPoint = point
                if(currentY - previousY > 0)
                {
                    toTopConstraint.constant += 10
                }
                else
                {
                    toTopConstraint.constant -= 10
                }
                if(toTopConstraint.constant < -currentTitleView.frame.size.height)
                {
                    toTopConstraint.constant = -currentTitleView.frame.size.height
                }
                else if(toTopConstraint.constant > 0)
                {
                    toTopConstraint.constant = 0
                }

            }
        }
        else
        {
            return
        }
    }
    
    func segPageChange(sender : AnyObject)
    {
        var seg : UISegmentedControl = sender as UISegmentedControl
        if(seg.selectedSegmentIndex == 0)
        {
            self.currentScroll.setContentOffset(CGPointMake(0, 0), animated: true)
        }
        else
        {
            self.currentScroll.setContentOffset(CGPointMake(currentScroll.frame.size.width, 0), animated: true)
        }
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        var contentOff = scrollView.contentOffset
        if(scrollView == currentScroll)
        {
            self.artComment?.currentTableV.contentOffset.y = 0
            self.artCollection?.currentCollection.contentOffset.y = 0
        }

        if(contentOff.x == 0)
        {
            self.filterSeg.selectedSegmentIndex = 0
        }
        else
        {
            self.filterSeg.selectedSegmentIndex = 1
        }
    }
    
    @IBAction func attenAction(sender: AnyObject) {
        var urlString = ZXY_ALLApi.ZXY_MainAPI + ZXY_ALLApi.ZXY_ChangeStatusAtten
        var myUserID : String? = LCYCommon.sharedInstance.userInfo?.userID
        if(myUserID == nil)
        {
            var story  = UIStoryboard(name: "AboutMe", bundle: nil)
            var vc     = story.instantiateViewControllerWithIdentifier("login") as UIViewController
            self.navigationController?.pushViewController(vc, animated: true)
            return
        }
        
        var changeUserID = userID
        var controlID    = ""
        if(currentUser?.isAttention == 1)
        {
            controlID = "2"
        }
        else
        {
            controlID = "1"
        }
        var parameter :Dictionary<String , AnyObject> = ["control" : controlID , "user_id" : (myUserID! as NSString).integerValue , "attention_user_id": (changeUserID as NSString).integerValue]
        ZXY_NetHelperOperate().startGetDataPost(urlString, parameter: parameter, successBlock: { [weak self] (returnDic) -> Void in
            var currentNum : Int = 0
            var t = self?.currentUser?.byAttention
            var numString : NSString = NSString(string: t!)
            if(self?.currentUser!.isAttention == 1)
            {
                self?.currentUser!.isAttention = 2
                currentNum = numString.integerValue - 1
            }
            else
            {
                self?.currentUser!.isAttention = 1
                currentNum = numString.integerValue + 1
            }
            self?.currentUser!.byAttention = "\(currentNum)"
            self?.setDownSuccessView()
            }) { (error) -> Void in
                
        }

    }
    
    @IBAction func toDataVC(sender : AnyObject)
    {
        if(userID == nil)
        {
            return
        }

        var myUserID = LCYCommon.sharedInstance.userInfo?.userID
        
        if(myUserID == nil)
        {
            var story  = UIStoryboard(name: "AboutMe", bundle: nil)
            var vc     = story.instantiateViewControllerWithIdentifier("login") as UIViewController
            self.navigationController?.pushViewController(vc, animated: true)
            return
        }
        else
        {
            self.performSegueWithIdentifier("toDateVC", sender: userID)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "toDateVC")
        {
            var vc : ZXY_DateVC = segue.destinationViewController as ZXY_DateVC
            vc.setUserID(userID)
            
        }
    }
}
