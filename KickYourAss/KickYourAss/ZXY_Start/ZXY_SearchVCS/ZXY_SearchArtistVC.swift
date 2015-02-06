//
//  ZXY_SearchArtistVC.swift
//  KickYourAss
//
//  Created by 宇周 on 15/2/6.
//  Copyright (c) 2015年 多思科技. All rights reserved.
//

import UIKit

class ZXY_SearchArtistVC: UIViewController {

    @IBOutlet var titleV: UIView!
    
    @IBOutlet weak var searchText: UITextField!
    
    @IBOutlet weak var currentTable: UITableView!
    
    private var userCityForFail = "大连市"
    private var allUserList : NSMutableArray? = NSMutableArray()
    private var locationService : BMKLocationService = BMKLocationService()
    private var cityNameSearch  : BMKGeoCodeSearch   = BMKGeoCodeSearch()
    
    var isDownLoad = false
    var currentPage = 1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.currentTable.tableFooterView = UIView(frame: CGRectZero)
        currentTable.addFooterWithCallback {[weak self] () -> Void in
            self?.currentTable.footerPullToRefreshText = "上拉加载更多"
            self?.currentTable.footerReleaseToRefreshText = "松开加载"
            self?.currentTable.footerRefreshingText    = "正在加载"
            self?.currentPage++
            self?.startGetArtistListData()
            
        }
        
        currentTable.addHeaderWithCallback { [weak self] () -> Void in
            self?.currentPage = 1
            self?.currentTable.headerPullToRefreshText = "下拉刷新"
            self?.currentTable.headerReleaseToRefreshText = "松开刷新"
            self?.currentTable.headerRefreshingText    = "正在刷新"
            self?.startGetArtistListData()
        }

        self.setNaviBarLeftImage("backArrow")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "搜索", style: UIBarButtonItemStyle.Bordered, target: self, action: Selector("startGetArtistListData"))
        self.navigationItem.titleView = self.titleV
        
        
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        locationService.delegate = nil
        cityNameSearch.delegate  = nil
        locationService.stopUserLocationService()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startGetArtistListData()
    {
        var userID : String? = LCYCommon.sharedInstance.userInfo?.userID
        if(userID == nil)
        {
            userID = ""
        }
        
        var cityNameTemp = ZXY_UserInfoDetail.sharedInstance.getUserCityName()
        if(cityNameTemp == nil)
        {
            locationService.delegate = self
            cityNameSearch.delegate = self
            locationService.startUserLocationService()
        }
        else
        {

        
            var apiString    = ZXY_ALLApi.ZXY_MainAPI + ZXY_ALLApi.ZXY_SearchListAPI
            var coor : Dictionary<String , String?>?     = ZXY_UserInfoDetail.sharedInstance.getUserCoordinate()
            var lat  = coor!["latitude"]!
            var log  = coor!["longitude"]!
            var apiParameter : Dictionary<String , String> = ["user_id" : "",
                "city"    : cityNameTemp!,
                "lng"     : "\(log)",
                "lat"     : "\(lat)",
                "p"       : "\(currentPage)",
                "nick_name" : searchText.text
            ]
            ZXY_NetHelperOperate.sharedInstance.startGetDataPost(apiString, parameter: apiParameter, successBlock: {[weak self] (returnDic) -> Void in
                
                if(self?.currentPage == 1)
                {
                    self?.allUserList?.removeAllObjects()
                    self?.allUserList?.addObjectsFromArray(ZXYSearchBaseModel(dictionary: returnDic).data)
                }
                else
                {
                    self?.allUserList?.addObjectsFromArray(ZXYSearchBaseModel(dictionary: returnDic).data)
                }
                
                self?.isDownLoad = false
                self?.reloadCurrentTable()
                }) {[weak self] (error) -> Void in
                    println(error)
                    self?.isDownLoad = false
                    self?.reloadCurrentTable()
            }
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

extension ZXY_SearchArtistVC : UITableViewDelegate , UITableViewDataSource , ZXY_SearchArtistCellDelegate
{
    func reloadCurrentTable()
    {
        currentTable.reloadData()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(ZXY_SearchArtistCellID) as ZXY_SearchArtistCell
        cell.setRateValue(indexPath.row)
        var currentUser = allUserList![indexPath.row] as ZXYData
        cell.userName.text = currentUser.nickName as String
        cell.userProfile.image = UIImage(named: "search_personCenter")
        cell.setIsAttensionFlag(currentUser)
        cell.delegate = self
        if let isNil = currentUser.score
        {
            var scoreFloat : Float = (currentUser.score as NSString).floatValue
            var scoreInt   : Int   = Int(scoreFloat)
            cell.setRateValue(scoreInt)
        }
        else
        {
            cell.setRateValue(0)
        }
        if let isNil = currentUser.headImage
        {
            if(currentUser.headImage.hasPrefix("http"))
            {
                var urlString =  currentUser.headImage
                cell.userProfile.setImageWithURL(NSURL(string: urlString))
            }
            else
            {
                var urlString = ZXY_ALLApi.ZXY_MainAPIImage + currentUser.headImage
                cell.userProfile.setImageWithURL(NSURL(string: urlString))
            }
        }
        else
        {
            cell.userProfile.image = UIImage(named: "search_personCenter")
        }
        var artCoor  = self.xYStringToCoor(currentUser.longitude, latitude: currentUser.latitude)
        var coor : Dictionary<String , String?>?     = ZXY_UserInfoDetail.sharedInstance.getUserCoordinate()
        var lat  = coor!["latitude"]!
        var log  = coor!["longitude"]!
        var userCoor = self.xYStringToCoor(log, latitude: lat)
        var distance = self.distanceCompareCoor(artCoor, userPosition: userCoor)
        cell.distanceLbl.text = "\(Double(round(100 * distance)/100)) km"
        cell.userProfileEdge.backgroundColor = self.colorWithIndexPath(indexPath)
        cell.conerLbl.backgroundColor        = self.colorWithIndexPath(indexPath)
        if(currentUser.role == "1")
        {
            cell.conerLbl.hidden = true
        }
        else
        {
            cell.conerLbl.hidden = false
        }
        
        if(currentUser.image.count > 0)
        {
            cell.userArtPhotoView.hidden = false
            cell.setArtsImage(currentUser.image as [ZXYImage])
        }
        else
        {
            cell.userArtPhotoView.hidden = true
        }
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var currentUser = allUserList![indexPath.row] as ZXYData
        if(currentUser.image.count > 0)
        {
            return 181
        }
        else
        {
            return 181 - 94
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let isNil = allUserList
        {
            return allUserList!.count
        }
        else
        {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var currentArtist = allUserList![indexPath.row] as ZXYData
        var story  = UIStoryboard(name: "ArtistDetailStoryBoard", bundle: nil)
        //var currentArtist : ZXYArtistListData = userListData[indexPath.row] as ZXYArtistListData
        var vc     = story.instantiateViewControllerWithIdentifier(ZXY_ArtistDetailVCID) as ZXY_ArtistDetailVC
        vc.setUserID(currentArtist.userId)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func attensionBtnClick(currentFlag: ZXYData) {
        var urlString = ZXY_ALLApi.ZXY_MainAPI + ZXY_ALLApi.ZXY_ChangeStatusAtten
        var userID : String? = LCYCommon.sharedInstance.userInfo?.userID
        if(userID == nil)
        {
            var story  = UIStoryboard(name: "AboutMe", bundle: nil)
            var vc     = story.instantiateViewControllerWithIdentifier("login") as UIViewController
            self.navigationController?.pushViewController(vc, animated: true)
            return
        }
        
        var changeUserID = currentFlag.userId
        var controlID    = ""
        if(currentFlag.isAttention == 1)
        {
            controlID = "2"
        }
        else
        {
            controlID = "1"
        }
        var parameter :Dictionary<String , AnyObject> = ["control" : controlID , "user_id" : (userID! as NSString).integerValue , "attention_user_id": (changeUserID as NSString).integerValue]
        ZXY_NetHelperOperate().startGetDataPost(urlString, parameter: parameter, successBlock: { [weak self] (returnDic) -> Void in
            if(currentFlag.isAttention == 1)
            {
                currentFlag.isAttention = 2
            }
            else
            {
                currentFlag.isAttention = 1
            }
            self?.currentTable.reloadData()
            
            }) { (error) -> Void in
                
        }
    }

}

extension ZXY_SearchArtistVC : BMKLocationServiceDelegate , BMKGeoCodeSearchDelegate
{
    func didUpdateBMKUserLocation(userLocation: BMKUserLocation!) {
        var lastLocation : CLLocation = userLocation.location
        var optionO : BMKReverseGeoCodeOption = BMKReverseGeoCodeOption()
        optionO.reverseGeoPoint = userLocation.location.coordinate
        ZXY_UserInfoDetail.sharedInstance.setUserCoordinate("\(lastLocation.coordinate.latitude)", longitude: "\(lastLocation.coordinate.longitude)")
        self.cityNameSearch.reverseGeoCode(optionO)
        
    }
    
    func onGetReverseGeoCodeResult(searcher: BMKGeoCodeSearch!, result: BMKReverseGeoCodeResult!, errorCode error: BMKSearchErrorCode) {
        if(error.value == BMK_SEARCH_NO_ERROR.value)
        {
            ZXY_UserInfoDetail.sharedInstance.setUserCityName(result.addressDetail.city)
            startGetArtistListData()
            searcher.delegate = nil
            locationService.stopUserLocationService()
        }
        else
        {
            ZXY_UserInfoDetail.sharedInstance.setUserCityName(userCityForFail)
            startGetArtistListData()
            searcher.delegate = nil
            locationService.stopUserLocationService()
        }
    }

}

extension ZXY_SearchArtistVC
{
    func colorWithIndexPath(indexPath: NSIndexPath) -> UIColor
    {
        var currentRow = indexPath.row
        switch currentRow % 5
        {
        case 0:
            return UIColor.greenColor()
        case 1:
            return UIColor.redColor()
        case 2:
            return UIColor.orangeColor()
        case 3:
            return UIColor.greenColor()
        case 4:
            return UIColor.purpleColor()
        default:
            return UIColor.greenColor()
        }
    }
    
    func distanceCompareCoor(artistPosition : CLLocationCoordinate2D? , userPosition : CLLocationCoordinate2D?) -> Double
    {
        if(artistPosition != nil && userPosition != nil)
        {
            var artistPot = BMKMapPointForCoordinate(artistPosition!)
            var userPot   = BMKMapPointForCoordinate(userPosition!)
            var distance  = BMKMetersBetweenMapPoints(artistPot, userPot)
            return distance/1000
        }
        else
        {
            return 0
        }
        
    }
    
    func  xYStringToCoor(longitude : String? , latitude: String?) -> CLLocationCoordinate2D?
    {
        if(longitude == nil || latitude == nil)
        {
            return nil
        }
        else
        {
            var logFloat = (longitude! as NSString).doubleValue
            var latFloat = (latitude!  as NSString).doubleValue
            return CLLocationCoordinate2DMake(latFloat, logFloat)
        }
        
    }

    
}

