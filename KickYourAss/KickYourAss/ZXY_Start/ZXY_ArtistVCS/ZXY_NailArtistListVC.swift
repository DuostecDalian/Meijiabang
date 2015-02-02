//
//  ZXY_NailArtistListVC.swift
//  KickYourAss
//
//  Created by 宇周 on 15/1/28.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

class ZXY_NailArtistListVC: UIViewController {

    @IBOutlet weak var currentTable: UITableView!
    private var locationService : BMKLocationService = BMKLocationService()
    private var cityNameSearch  : BMKGeoCodeSearch   = BMKGeoCodeSearch()
    private var userListData : NSMutableArray = NSMutableArray()
    private var isDown = false
    private var userCityForFail = "大连市"
    private var currentPage     : Int = 1
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
        startGetArtistListData()
    }
    
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        locationService.delegate = nil
        cityNameSearch.delegate = nil
        locationService.stopUserLocationService()
    }

    private func startGetArtistListData()
    {
        var cityNameTemp = ZXY_UserInfoDetail.sharedInstance.getUserCityName()
        if(cityNameTemp == nil)
        {
            locationService.delegate = self
            cityNameSearch.delegate = self
            locationService.startUserLocationService()
        }
        else
        {
            if(isDown)
            {
                currentTable.footerEndRefreshing()
                currentTable.headerEndRefreshing()
                return
            }
            isDown = true
            var urlString = ZXY_ALLApi.ZXY_MainAPI + ZXY_ALLApi.ZXY_UserListAPI
            var coor : Dictionary<String , String?>?     = ZXY_UserInfoDetail.sharedInstance.getUserCoordinate()
            var lat  = coor!["latitude"]!
            var log  = coor!["longitude"]!
            var parameter : Dictionary<String , String> = ["city" : cityNameTemp! ,
                "user_id" : "" ,
                "lng" : log! ,
                "lat" : lat!   ,
                "control" : "1" ,
                "p"       : "\(currentPage)"
            ]
            
            ZXY_NetHelperOperate().startGetDataPost(urlString, parameter: parameter, successBlock: {[weak self] (returnDic) -> Void in
                
                if(self?.currentPage == 1)
                {
                    self?.userListData.removeAllObjects()
                    self?.userListData.addObjectsFromArray(ZXYArtistListBase(dictionary: returnDic).data)
                }
                else
                {
                    self?.userListData.addObjectsFromArray(ZXYArtistListBase(dictionary: returnDic).data)
                }
                self?.reloadTableView()
                self?.currentTable.footerEndRefreshing()
                self?.currentTable.headerEndRefreshing()
                self?.isDown = false
                }, failBlock: { [weak self](error) -> Void in
                    self?.currentTable.footerEndRefreshing()
                    self?.currentTable.headerEndRefreshing()
                    self?.isDown = false
                println(error)
            })
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ZXY_NailArtistListVC : BMKLocationServiceDelegate , BMKGeoCodeSearchDelegate
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

extension ZXY_NailArtistListVC: UITableViewDelegate , UITableViewDataSource
{
    func reloadTableView()
    {
        self.currentTable.reloadData()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var currentRow = indexPath.row
        var currentSection = indexPath.section
        var cell = tableView.dequeueReusableCellWithIdentifier(ZXY_ArtistListCellID) as ZXY_ArtistListCell
        var currentArtist : ZXYArtistListData = userListData[currentRow] as ZXYArtistListData
        cell.nameLbl.text  = currentArtist.nickName
        cell.numOfArt.text = "作品：\(currentArtist.albumCount)"
        cell.likeNumLbl.text = currentArtist.byAttention
        
        var headImg = ZXY_ALLApi.ZXY_MainAPIImage + currentArtist.headImage
        if(currentArtist.headImage.hasPrefix("http"))
        {
            headImg = currentArtist.headImage
        }
        var coor : Dictionary<String , String?>?     = ZXY_UserInfoDetail.sharedInstance.getUserCoordinate()
        var lat  = coor!["latitude"]!
        var log  = coor!["longitude"]!
        var currentUserL = self.xYStringToCoor(log, latitude: lat)
        var artistL      = self.xYStringToCoor(currentArtist.longitude, latitude: currentArtist.latitude)
        var distance = self.distanceCompareCoor(artistL, userPosition: currentUserL)
        cell.distanceLbl.text = "\(Double(round(100 * distance)/100)) km"
        cell.setHeadImageURL(NSURL(string: headImg))
        cell.setRateValue((currentArtist.score as NSString).integerValue)
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 99
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userListData.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var story  = UIStoryboard(name: "ArtistDetailStoryBoard", bundle: nil)
        var currentArtist : ZXYArtistListData = userListData[indexPath.row] as ZXYArtistListData
        var vc     = story.instantiateViewControllerWithIdentifier(ZXY_ArtistDetailVCID) as ZXY_ArtistDetailVC
        vc.setUserID(currentArtist.userId)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension ZXY_NailArtistListVC
{
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
