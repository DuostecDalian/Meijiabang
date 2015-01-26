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
    let toHeaderMax: CGFloat = 239.0
    let mapScale   : CLLocationDegrees = 0.001
    
    var locService = BMKLocationService()
    
    var isMapSpanFirst = true
    private var previousPointY : CGFloat = 0.0
    private var userLocationCoor : CLLocationCoordinate2D?
    
    private var isDownLoad :  Bool       = false
    private var isLocationFirst : Bool   = true
    private var previousTimeStamp  = NSDate().timeIntervalSince1970
    
    
    @IBOutlet weak var tableConsYToHeader: NSLayoutConstraint!
    @IBOutlet weak var targetImage: UIImageView!
    @IBOutlet weak var currentTable: UITableView!
    @IBOutlet weak var littleBoy: UIImageView!
    @IBOutlet weak private var currentMap: BMKMapView!
    
    private var cityName : String?
    private var currentPage = 1
    
    private var allUserList : NSMutableArray? = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.startInitTable()
        self.startInitLocationManager()
        self.startInitLittleBoy()
        self.startInitTargetImage()
        self.startInitMapView()
        // 判断网络连接状态的代理
        self.startCheckNetConnect(whenBegain: { () -> Void in
            
        }) { () -> Void in
            
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    override func viewWillAppear(animated: Bool) {
        currentMap.viewWillAppear()
        currentMap.delegate = self
    
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
        currentMap.showsUserLocation = true
        currentMap.region  = BMKCoordinateRegion(center: currentMap.centerCoordinate, span: BMKCoordinateSpan(latitudeDelta: mapScale, longitudeDelta: mapScale))
    }
    
    override func viewWillDisappear(animated: Bool) {
        currentMap.viewWillDisappear()
        currentMap.delegate = nil
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
        
        locService.delegate = self
        locService.startUserLocationService()
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
            if(currentTable.footerRefreshing)
            {
                currentTable.footerEndRefreshing()
            }
            return
        }
        else
        {
            isDownLoad = true
        }
        littleBoy.startAnimating()
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
            return
        }
        
        if(cityName == nil)
        {
            return
        }
        var apiString    = ZXY_ALLApi.ZXY_MainAPI + ZXY_ALLApi.ZXY_SearchListAPI
        var apiParameter : Dictionary<String , String> = ["user_id" : "",
            "city"    : cityName!,
            "lng"     : "\(location!.longitude)",
            "lat"     : "\(location!.latitude)",
            "p"       : "\(currentPage)",
        ]
        ZXY_NetHelperOperate.sharedInstance.startGetDataPost(apiString, parameter: apiParameter, successBlock: {[weak self] (returnDic) -> Void in
            println("成功")
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
extension ZXY_NailSearchVC : BMKMapViewDelegate , BMKLocationServiceDelegate
{
    
    func didUpdateBMKUserLocation(userLocation: BMKUserLocation!) {
        //currentMap.setCenterCoordinate(userLocation.location.coordinate, animated: false)
        var currentTimeStamp = NSDate().timeIntervalSince1970
        if(currentTimeStamp - previousTimeStamp > 20)
        {
            userLocationCoor = userLocation.location.coordinate
        }
        
        if(isLocationFirst)
        {
            self.setCurrentUserLocation(userLocation: userLocation.location.coordinate)
            self.changeUserLocationToCityName(userLocation.location)
            isLocationFirst = false
            userLocationCoor = userLocation.location.coordinate
        }
        
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
        if(annotation.isKindOfClass(BMKPointAnnotation.self))
        {
            var bdAnnotation  = mapView.dequeueReusableAnnotationViewWithIdentifier("hello")
            if(bdAnnotation == nil)
            {
                 bdAnnotation = BMKPinAnnotationView(annotation: annotation, reuseIdentifier: "hello")
            }
            else
            {
                bdAnnotation.annotation = annotation
            }
            
            return bdAnnotation
        }
        else
        {
            return nil
        }
        
    }
    
    func mapViewDidFinishLoading(mapView: BMKMapView!) {
        print("load---------->")
        
    }
    
    func mapView(mapView: BMKMapView!, regionDidChangeAnimated animated: Bool) {
        if(isDownLoad)
        {
            return
        }
        self.startInitLittleBoy()
        self.changeUserLocationToCityName(CLLocation(latitude: mapView.region.center.latitude, longitude: mapView.region.center.longitude))
        targetImage.hidden = false
    }
    
    func changeUserLocationToCityName(location : CLLocation?)
    {
        var geo : CLGeocoder = CLGeocoder()
        
        if let isNil = location
        {
            geo.reverseGeocodeLocation(location, completionHandler: {[weak self] (loInfo : [AnyObject]!, error: NSError!) -> Void in
                if(loInfo == nil)
                {
                    if(self?.allUserList?.count == 0)
                    {
                        self?.currentTable.hidden = true
                    }
                    else
                    {
                        self?.currentTable.hidden = false
                    }
                    return
                }
                if(loInfo.count > 0)
                {
                    var place: CLPlacemark = loInfo[0] as CLPlacemark
                    self?.cityName               = place.locality
                    self?.currentPage = 1
                    self?.startPOSTSearchList(location!.coordinate)
                }
                else
                {
                    if(self?.allUserList?.count == 0)
                    {
                        self?.currentTable.hidden = true
                    }
                    else
                    {
                        self?.currentTable.hidden = false
                    }
                }
            })
        }
        else
        {
            if(self.allUserList?.count == 0)
            {
                self.currentTable.hidden = true
            }
            else
            {
                self.currentTable.hidden = false
            }
            return
        }

    }
    
}

// MARK: tableView Delegate , DataSource and reloadData
extension ZXY_NailSearchVC : UITableViewDelegate , UITableViewDataSource , UIScrollViewDelegate
{
    func reloadCurrentTable()
    {
        currentTable.reloadData()
        for var i = 0; i < allUserList?.count ;i++
        {
            var currentUser = allUserList![i] as ZXYData
            var anno : BMKPointAnnotation = BMKPointAnnotation()
            anno.coordinate = self.xYStringToCoor(currentUser.longitude, latitude: currentUser.latitude)!
            currentMap.addAnnotation(anno)
        }
        if(currentTable.hidden)
        {
                        currentTable.hidden = false
        }
        
        if(targetImage.hidden)
        {
            targetImage.hidden = false
            littleBoy.image = UIImage(named: "search_personCenter")
        }
        
        if(currentTable.footerRefreshing)
        {
            currentTable.footerEndRefreshing()
        }
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
            var urlString = ZXY_ALLApi.ZXY_MainAPIImage + currentUser.headImage
            cell.userProfile.setImageWithURL(NSURL(string: urlString))
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
    
    // MARK: 控制tableView拖拽
    func scrollViewDidScroll(scrollView: UIScrollView) {
//        println("contentInset -> \(scrollView.contentInset.top)")
//        println("contentOffset -> \(scrollView.contentOffset.y)")
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




