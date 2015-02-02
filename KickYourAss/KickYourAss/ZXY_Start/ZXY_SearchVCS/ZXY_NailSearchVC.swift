//
//  ZXY_NailSearchVC.swift
//  KickYourAss
//
//  Created by 宇周 on 15/1/20.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit
import MapKit


class ZXY_NailSearchVC: UIViewController {
    var toHeaderMax: CGFloat = 239.0
    let mapScale   : CLLocationDegrees = 0.001
    
    var locService = BMKLocationService()
    //var anno: ZXY_BMKAnnotation?
    var annos : [ZXY_BMKAnnotation]! = []
    var isMapSpanFirst = true
    private var previousPointY : CGFloat = 0.0
    private var userLocationCoor : CLLocationCoordinate2D?
    //private var geo : CLGeocoder = CLGeocoder()
    private var search : BMKGeoCodeSearch = BMKGeoCodeSearch()
    private var isDownLoad :  Bool       = false
    private var isLocationFirst : Bool   = true
    private var previousTimeStamp  = NSDate().timeIntervalSince1970
    
    
    @IBOutlet weak var tableConsYToHeader: NSLayoutConstraint!
    @IBOutlet weak var targetImage: UIImageView!
    @IBOutlet weak var currentTable: UITableView!
    @IBOutlet weak var littleBoy: UIImageView!
    @IBOutlet weak private var currentMap: BMKMapView!
    
    private var cityName : String? = "大连市"
    private var currentPage = 1
    
    private var allUserList : NSMutableArray? = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableConsYToHeader.constant = CGFloat(self.view.frame.size.height / 2.0)
        toHeaderMax        = CGFloat(self.view.frame.size.height / 2.0)
        self.startInitMapView()
        self.startInitTable()
        self.startInitLocationManager()
        self.startInitLittleBoy()
        self.startInitTargetImage()
        
        
        
        
        // 判断网络连接状态的代理
        self.startCheckNetConnect(whenBegain: { () -> Void in
            
        }) { () -> Void in
            
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        currentMap.viewWillAppear()
        currentMap.delegate = self
        locService.delegate = self
        search.delegate = self
        locService.startUserLocationService()
    }
    
    override func viewWillDisappear(animated: Bool) {
        currentMap.viewWillDisappear()
        currentMap.delegate = nil
        search.delegate = nil
        locService.delegate = nil
        locService.stopUserLocationService()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    
    func startInitTable()
    {
        currentTable.hidden = true
        currentTable.tableFooterView = UIView(frame: CGRectZero)
        currentTable.addFooterWithCallback { [weak self] () -> Void in
            self?.currentTable.footerPullToRefreshText = "上拉加载更多"
            self?.currentTable.footerReleaseToRefreshText = "松开加载"
            self?.currentTable.footerRefreshingText    = "正在加载"
            self?.currentPage++
            self?.startPOSTSearchList(self?.userLocationCoor)
            println()
        }
    }
    
    func setMapViewDefault() -> Void
    {
        currentMap.showsUserLocation = false
        currentMap.region  = BMKCoordinateRegion(center: currentMap.centerCoordinate, span: BMKCoordinateSpan(latitudeDelta: mapScale, longitudeDelta: mapScale))
    }
    
        
    func startInitLittleBoy()
    {
        littleBoy.image = UIImage(named: "search_personCenter")
        var images : [UIImage]  = [UIImage(named: "search_personLeft")!, UIImage(named: "search_personCenter")!, UIImage(named: "search_personRight")!]
        littleBoy.animationImages      = images
        littleBoy.animationDuration    = 0.5
        littleBoy.animationRepeatCount = 0
    }
    
    func startInitMapView()
    {
        
    }
    
       
    func startInitLocationManager()
    {
    
//        locService.delegate = self
//        locService.startUserLocationService()
    }
    
    func startInitTargetImage()
    {
        targetImage.userInteractionEnabled = true
        var tapGes = UITapGestureRecognizer(target: self, action: Selector("reFreshLocation"))
        targetImage.addGestureRecognizer(tapGes)
    }
    
    func reFreshLocation()
    {
        if(userLocationCoor != nil)
        {
            currentPage = 1
            self.setCurrentUserLocation(userLocation: userLocationCoor!)
            self.startPOSTSearchList(userLocationCoor)
        }
    }
    
    // 定位用户位置坐标
    private func setCurrentUserLocation(userLocation location: CLLocationCoordinate2D) -> Void
    {
        
        var region : BMKCoordinateRegion = BMKCoordinateRegion(center: location, span: BMKCoordinateSpan(latitudeDelta: mapScale, longitudeDelta: mapScale))
        
        if(isMapSpanFirst)
        {
            region = BMKCoordinateRegion(center: location, span: BMKCoordinateSpan(latitudeDelta: mapScale, longitudeDelta: mapScale))
            isMapSpanFirst = false
        }
        currentMap.setRegion(region, animated: false)
        currentMap.setCenterCoordinate(location, animated: false)
        currentMap.showsUserLocation = false
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

// MARK: - 地图与定位的相关代理 
extension ZXY_NailSearchVC
{
    func startPOSTSearchList(location: CLLocationCoordinate2D?) -> Void
    {
        if(isDownLoad)
        {
            currentTable.footerEndRefreshing()
            
            return
        }
        else
        {
            isDownLoad = true
        }
        
        if(location == nil)
        {
            if(allUserList?.count == 0)
            {
                self.currentTable.hidden = true
            }
            else
            {
                self.currentTable.hidden = false
            }
            isDownLoad = false
            return
        }
        
        if(cityName == nil)
        {
            isDownLoad = false
            return
        }
        littleBoy.startAnimating()
        var locations = ZXY_LocationRelative.sharedInstance.gpsToBD(location!)
        var apiString    = ZXY_ALLApi.ZXY_MainAPI + ZXY_ALLApi.ZXY_SearchListAPI
        var apiParameter : Dictionary<String , String> = ["user_id" : "",
            "city"    : cityName!,
            "lng"     : "\(locations.longitude)",
            "lat"     : "\(locations.latitude)",
            "p"       : "\(currentPage)",
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
            self?.littleBoy.stopAnimating()
            self?.isDownLoad = false
            self?.reloadCurrentTable()
        }) {[weak self] (error) -> Void in
            println(error)
            self?.littleBoy.stopAnimating()
            self?.isDownLoad = false
            self?.reloadCurrentTable()
        }
        
    
    }
}


// MARK: - 地图与定位的相关代理
extension ZXY_NailSearchVC :  BMKMapViewDelegate , BMKLocationServiceDelegate , BMKGeoCodeSearchDelegate
{
    func didUpdateBMKUserLocation(userLocation: BMKUserLocation!) {
        var lastLocation : CLLocation = userLocation.location
        
        ZXY_UserInfoDetail.sharedInstance.setUserCoordinate("\(lastLocation.coordinate.latitude)", longitude: "\(lastLocation.coordinate.longitude)")
        var currentTimeStamp = NSDate().timeIntervalSince1970
        if(currentTimeStamp - previousTimeStamp > 20)
        {
            userLocationCoor = lastLocation.coordinate
            previousTimeStamp = currentTimeStamp
            self.changeUserLocationToCityName(lastLocation)
        }

        if(isLocationFirst)
        {
            userLocationCoor = lastLocation.coordinate
            self.setCurrentUserLocation(userLocation: lastLocation.coordinate)
            self.changeUserLocationToCityName(lastLocation)
            isLocationFirst = false
            
        }

    }
    
    func didFailToLocateUserWithError(error: NSError!) {
        
    }
    
    
    // MARK: - MapViewDelegate
    func mapView(mapView: BMKMapView!, regionWillChangeAnimated animated: Bool) {
        if(isDownLoad)
        {
            return
        }
        currentTable.hidden = true
        littleBoy.image = UIImage(named: "search_location")
        targetImage.hidden = true
    }
    
    func mapView(mapView: BMKMapView!, viewForAnnotation annotation: BMKAnnotation!) -> BMKAnnotationView! {
        if(annotation.isKindOfClass(ZXY_BMKAnnotation.self))
        {
            var annoView : ZXY_DAnnotationView? = mapView.dequeueReusableAnnotationViewWithIdentifier("zxy_Anno") as? ZXY_DAnnotationView
            if(annoView == nil)
            {
                annoView = ZXY_DAnnotationView(annotation: annotation, reuseIdentifier: "zxy_Anno")
            }
            else
            {
                annoView!.annotation = annotation
            }
            
            var zxyAnno : ZXY_BMKAnnotation = annotation as ZXY_BMKAnnotation
            if(zxyAnno.imgURL != nil)
            {
                annoView?.titleImg.setImageWithURL(zxyAnno.imgURL!)
                
            }
            annoView?.userID = zxyAnno.userID
            return annoView
        }
        else
        {
            var annoView = mapView.dequeueReusableAnnotationViewWithIdentifier("zxy_Anno")
            if(annoView == nil)
            {
                annoView = ZXY_DAnnotationView(annotation: annotation, reuseIdentifier: "zxy_Anno")
            }
            else
            {
                annoView.annotation = annotation
            }
            
            return annoView

        }
    }
    
    func mapView(mapView: BMKMapView!, didSelectAnnotationView view: BMKAnnotationView!) {
        if(view.isKindOfClass(ZXY_DAnnotationView.self))
        {
            var annoView = view as ZXY_DAnnotationView
            var story  = UIStoryboard(name: "ArtistDetailStoryBoard", bundle: nil)
            var vc     = story.instantiateViewControllerWithIdentifier(ZXY_ArtistDetailVCID) as ZXY_ArtistDetailVC
            if(annoView.userID != nil)
            {
                vc.setUserID(annoView.userID!)
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else
            {
                return
            }
            
        }
    }
    
    func mapView(mapView: BMKMapView!, regionDidChangeAnimated animated: Bool) {
        if(isDownLoad)
        {
            return
        }
        self.startInitLittleBoy()
        targetImage.hidden = false
        var currentTimeStamp = NSDate().timeIntervalSince1970
        self.changeUserLocationToCityName(CLLocation(latitude: mapView.region.center.latitude, longitude: mapView.region.center.longitude))
        self.startPOSTSearchList(mapView.region.center)
        
        
    }
    
    
    func onGetReverseGeoCodeResult(searcher: BMKGeoCodeSearch!, result: BMKReverseGeoCodeResult!, errorCode error: BMKSearchErrorCode) {
        if(error.value == BMK_SEARCH_NO_ERROR.value)
        {
            cityName = result.addressDetail.city
            ZXY_UserInfoDetail.sharedInstance.setUserCityName(cityName)
        }
    }
    
    
    func changeUserLocationToCityName(location : CLLocation?)
    {
        var currentTimeStamp = NSDate().timeIntervalSince1970
        if (location != nil)
        {
            var geoOption  = BMKReverseGeoCodeOption()
            geoOption.reverseGeoPoint = location!.coordinate
            //search.delegate = self
            var flag : Bool = search.reverseGeoCode(geoOption)
            if(flag)
            {
                
            }
            else
            {
                //self.showAlertEasy("提示", messageContent: "城市信息获取失败")
            }
            
        }
    }
    
}

// MARK: tableView Delegate , DataSource and reloadData
extension ZXY_NailSearchVC : UITableViewDelegate , UITableViewDataSource , UIScrollViewDelegate
{
    func reloadCurrentTable()
    {
        currentTable.reloadData()
        annos.removeAll(keepCapacity: false)
        for var i = 0; i < allUserList?.count ;i++
        {
            if(i <= 5)
            {
                var currentUser : ZXYData = allUserList![i] as ZXYData
                
                var headImg: String? = ZXY_ALLApi.ZXY_MainAPIImage + currentUser.headImage
                if(currentUser.headImage.hasPrefix("http"))
                {
                    headImg = currentUser.headImage
                }
                var coordinatee : CLLocationCoordinate2D?
                coordinatee = self.xYStringToCoor(currentUser.longitude, latitude: currentUser.latitude)?
                if(coordinatee == nil)
                {
                    continue
                }
                
                var anno = ZXY_BMKAnnotation(location: coordinatee!)
                if(headImg != nil)
                {
                    var url: NSURL? = NSURL(string: headImg!)
                    anno.setImgURL(url)
                }
                anno.setCoordinate(coordinatee!)
                anno.setUserID(currentUser.userId)
                annos.append(anno)
            }
        }
        currentMap.removeAnnotations(currentMap.annotations)
        currentMap.addAnnotations(annos)
        if(currentTable.hidden)
        {
            currentTable.hidden = false
        }
        
        if(targetImage.hidden)
        {
            targetImage.hidden = false
            littleBoy.image = UIImage(named: "search_personCenter")
        }
        
        currentTable.footerEndRefreshing()
        
        if(allUserList?.count == 0)
        {
            currentTable.hidden = true
        }

        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(ZXY_SearchArtistCellID) as ZXY_SearchArtistCell
        cell.setRateValue(indexPath.row)
        var currentUser = allUserList![indexPath.row] as ZXYData
        cell.userName.text = currentUser.nickName as String
        cell.userProfile.image = UIImage(named: "search_personCenter")
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
        var distance = self.distanceCompareCoor(artCoor, userPosition: userLocationCoor)
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
    
    // MARK: 控制tableView拖拽
    func scrollViewDidScroll(scrollView: UIScrollView) {
        var contentOffY : CGFloat = scrollView.contentOffset.y
        tableConsYToHeader.constant -= contentOffY
        if(tableConsYToHeader.constant < 0)
        {
            tableConsYToHeader.constant = 0
        }
        else if(tableConsYToHeader.constant > toHeaderMax)
        {
            tableConsYToHeader.constant = toHeaderMax
        }
        else
        {
            //tableConsYToHeader.constant = contentOffY
            scrollView.contentOffset.y = 0
        }
//        if(contentOffY >= 0)
//        {
//            if(tableConsYToHeader.constant > 0)
//            {
//                scrollView.contentOffset.y = 0
//                tableConsYToHeader.constant -= contentOffY
//            }
//            previousPointY = contentOffY
//        }
//        else
//        {
//            if(tableConsYToHeader.constant <= toHeaderMax)
//            {
//                scrollView.contentOffset.y = 0
//                tableConsYToHeader.constant -= contentOffY
//            }
//            previousPointY = contentOffY
//        }
        //---------
//        if(previousPointY - contentOffY > 0)
//        {
//            if(self.tableConsYToHeader.constant >= toHeaderMax)
//            {
//                
//                return
//            }
//            else
//            {
//                self.tableConsYToHeader.constant += 2
//                if(self.tableConsYToHeader.constant >= toHeaderMax)
//                {
//                    
//                    self.tableConsYToHeader.constant = toHeaderMax
//                }
//                
//                self.view.layoutIfNeeded()
//            }
//            previousPointY = contentOffY
//        }
//        else
//        {
//            if(self.tableConsYToHeader.constant <= 0)
//            {
//                
//                return
//            }
//            else
//            {
//                self.tableConsYToHeader.constant -= 2
//                if(self.tableConsYToHeader.constant <= 0)
//                {
//                    self.tableConsYToHeader.constant = 0
//                   
//                }
//                
//                self.view.layoutIfNeeded()
//            }
//            previousPointY = contentOffY
//        }
    }
    
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




