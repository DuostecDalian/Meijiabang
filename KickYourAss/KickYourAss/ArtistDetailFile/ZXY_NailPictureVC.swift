//
//  ZXY_NailPictureVC.swift
//  KickYourAss
//
//  Created by 宇周 on 15/2/2.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

class ZXY_NailPictureVC: UIViewController {

    @IBOutlet weak var currentTabBar: UITabBar!
    
    @IBOutlet weak var firstItem: UITabBarItem!
    
    @IBOutlet weak var secondItem: UITabBarItem!
    
    @IBOutlet weak var thirdItem: UITabBarItem!
    
    @IBOutlet var tabBarItems: [UITabBarItem]!
    
    private var userID : String? = ""
    private var albumID : String? = ""
    private var dataForTable : ZXY_PictureDetailBase?
    
    @IBOutlet weak var noDataView: UIView!
    
    
    @IBOutlet weak var currentTable: UITableView!
    
    
    override func viewDidLoad() {
        var tapReload = UITapGestureRecognizer(target: self, action: Selector("startDownLoadData"))
        self.noDataView.addGestureRecognizer(tapReload)
        self.noDataView.userInteractionEnabled = true
        super.viewDidLoad()
        self.begainInit()
        self.startDownLoadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    func begainInit()
    {
        currentTabBar.hidden = true
        currentTable.hidden  = true
    }
    
    func startInitTabBar()
    {
        let attrBarArr = NSArray(contentsOfFile: NSBundle.mainBundle().pathForResource("tabAttrPlist", ofType: "plist")!)
        for var i = 0; i < self.tabBarItems.count ;i++
        {
//            var currentAttr : Dictionary<String , String>  = attrBarArr![i] as Dictionary<String , String>
//            var selectImageN = currentAttr["selectImage"]
//            var imageN       = currentAttr["image"]
//            var titleN       = currentAttr["title"]
//            var selectTitleN = currentAttr["selectTitle"]
            var currentItem = tabBarItems[i]
//            currentItem.title = titleN
//            currentItem.image = UIImage(named: imageN!)
//            currentItem.selectedImage = UIImage(named: selectImageN!)
            currentItem.setTitleTextAttributes([NSForegroundColorAttributeName : ZXY_AllColor.SEARCH_RED_COLOR], forState: UIControlState.Selected)
            currentItem.setTitleTextAttributes([NSForegroundColorAttributeName : ZXY_AllColor.TABBAR_GRAY_COLOR], forState: UIControlState.Normal)
            
        }
    }
    
    func setAlbumID(album_id : String! , user_id : String?)
    {
        albumID = album_id
        if(user_id != nil)
        {
            self.userID = user_id
        }
    }
    
    func startDownLoadData()
    {
        MBProgressHUD().show(true)
        var urlString = ZXY_ALLApi.ZXY_MainAPI + ZXY_ALLApi.ZXY_AlbumDetailAPI
        ZXY_NetHelperOperate().startGetDataPost(urlString, parameter: ["user_id": self.userID! ,"album_id": albumID!], successBlock: {[weak self] (returnDic) -> Void in
            MBProgressHUD().hide(true)
            self?.dataForTable = ZXY_PictureDetailBase(dictionary: returnDic)
            self?.reloadCurrentTable()
            self?.startReloadTabItem()
            println()
        }) {[weak self] (error) -> Void in
            println(error)
             MBProgressHUD().hide(true)
            self?.startReloadTabItem()
            self?.reloadCurrentTable()
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

extension ZXY_NailPictureVC : UITabBarDelegate
{
    func startReloadTabItem()
    {
        if(dataForTable != nil)
        {
            self.currentTabBar.hidden = false
            var isAgree   = dataForTable!.data.isAgree
            var isCollect = dataForTable!.data.isCollect
            
            if(Int(isAgree) == 0)
            {
                firstItem.selectedImage = UIImage(named: "heart_red")
                firstItem.image         = UIImage(named: "heart_red")
                firstItem.title         = "点赞"
                firstItem.setTitleTextAttributes([NSForegroundColorAttributeName : ZXY_AllColor.SEARCH_RED_COLOR], forState: UIControlState.Selected)
                firstItem.setTitleTextAttributes([NSForegroundColorAttributeName : ZXY_AllColor.SEARCH_RED_COLOR], forState: UIControlState.Normal)
            }
            else
            {
                firstItem.selectedImage = UIImage(named: "heart_gray")
                firstItem.image         = UIImage(named: "heart_gray")
                firstItem.title         = "已点赞"
                firstItem.setTitleTextAttributes([NSForegroundColorAttributeName : ZXY_AllColor.TABBAR_GRAY_COLOR], forState: UIControlState.Selected)
                firstItem.setTitleTextAttributes([NSForegroundColorAttributeName : ZXY_AllColor.TABBAR_GRAY_COLOR], forState: UIControlState.Normal)

            }
            
            if(Int(isCollect) == 0)
            {
                secondItem.selectedImage = UIImage(named: "star_red")
                secondItem.image         = UIImage(named: "star_red")
                secondItem.title         = "收藏"
                secondItem.setTitleTextAttributes([NSForegroundColorAttributeName : ZXY_AllColor.SEARCH_RED_COLOR], forState: UIControlState.Selected)
                secondItem.setTitleTextAttributes([NSForegroundColorAttributeName : ZXY_AllColor.SEARCH_RED_COLOR], forState: UIControlState.Normal)
            }
            else
            {
                secondItem.selectedImage = UIImage(named: "star_gray")
                secondItem.image         = UIImage(named: "star_gray")
                secondItem.title         = "已收藏"
                secondItem.setTitleTextAttributes([NSForegroundColorAttributeName : ZXY_AllColor.TABBAR_GRAY_COLOR], forState: UIControlState.Selected)
                secondItem.setTitleTextAttributes([NSForegroundColorAttributeName : ZXY_AllColor.TABBAR_GRAY_COLOR], forState: UIControlState.Normal)
            }
            thirdItem.selectedImage = UIImage(named: "share_red")
            thirdItem.image = UIImage(named: "share_red")
            thirdItem.title         = "分享"
            thirdItem.setTitleTextAttributes([NSForegroundColorAttributeName : ZXY_AllColor.SEARCH_RED_COLOR], forState: UIControlState.Selected)
            thirdItem.setTitleTextAttributes([NSForegroundColorAttributeName : ZXY_AllColor.SEARCH_RED_COLOR], forState: UIControlState.Normal)
        }
    }
    
    func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem!) {
        
    }
}

extension ZXY_NailPictureVC : UITableViewDelegate , UITableViewDataSource
{
    
    func reloadCurrentTable()
    {
        if(dataForTable == nil || dataForTable?.data == nil)
        {
            
            
            currentTable.hidden = true
            noDataView.hidden = false
            
        }
        else
        {
            if(dataForTable?.result == 1003)
            {
                currentTable.reloadData()
                currentTable.hidden = true
                noDataView.hidden = false
                return
            }
            currentTable.hidden = false
            noDataView.hidden = true
        }
        currentTable.reloadData()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var currentSection = indexPath.section
        var currentRow     = indexPath.row
        if(currentRow == 0)
        {
            let cell = tableView.dequeueReusableCellWithIdentifier(ZXY_PictureHeaderCellID) as ZXY_PictureHeaderCell
            if(dataForTable != nil)
            {
                var userInfo : ZXY_PictureDetailUser = dataForTable!.data.user
                
                cell.nameLbl.text = userInfo.nickName
                cell.albumNameLbl.text = "图集\(userInfo.albumCount)"
                cell.attenNumLbl.text  = "关注\(userInfo.byAttention)"
                var urlString = ZXY_ALLApi.ZXY_MainAPIImage + userInfo.headImage
                if(userInfo.headImage.hasPrefix("http"))
                {
                    urlString = userInfo.headImage
                }
                cell.setProfileImage(NSURL(string: urlString)!)
            }
            return cell
        }
        else if (currentRow == 1)
        {
            let cell = tableView.dequeueReusableCellWithIdentifier(ZXY_PictureImageCellID) as ZXY_PictureImageCell
            if(dataForTable?.data.images.count > 0)
            {
                var userInfo : ZXY_PictureDetailImages = dataForTable!.data.images[0] as ZXY_PictureDetailImages
                var urlString = ZXY_ALLApi.ZXY_MainAPIImage + userInfo.imagePath
                cell.imgBig.setImageWithURL(NSURL(string: urlString))
            }
            return cell
        }
        else
        {
            let cell = tableView.dequeueReusableCellWithIdentifier(ZXY_PictureFootterCellID) as ZXY_PictureFootterCell
            if(dataForTable != nil)
            {
                var currentInfo = dataForTable!.data.dataDescription
                cell.desLbl.text     = currentInfo
            }
            
            return cell
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var currentRow = indexPath.row
        var currentSection = indexPath.section
        if(currentRow == 0)
        {
            return 70
        }
        else if(currentRow == 1)
        {
            if(dataForTable?.data.images.count > 0)
            {
                var userInfo : ZXY_PictureDetailImages = dataForTable!.data.images[0] as ZXY_PictureDetailImages
                var height   = (userInfo.height as NSString).floatValue
                var width    = (userInfo.width as NSString).floatValue
                var radio    = height / width
                return (tableView.frame.width - 20) * CGFloat(radio)
            }
            return 114
        }
        else
        {
            return 49
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
}