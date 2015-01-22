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
    var locationManager : CLLocationManager!
    var isMapSpanFirst = true
    private var previousPointY : CGFloat = 0.0
    private var isDownLoad :  Bool       = false
    
    
    @IBOutlet weak var tableConsYToHeader: NSLayoutConstraint!
    @IBOutlet weak var targetImage: UIImageView!
    @IBOutlet weak var currentTable: UITableView!
    @IBOutlet weak var littleBoy: UIImageView!
    @IBOutlet weak private var currentMap: MKMapView!
    
    private var cityName : String?
    private var currentPage = 1
    
    private var allUserList : ZXYSearchBaseModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentTable.hidden = true
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
        // 判断定位系统有没有授权
        locationManager          = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        if(locationManager.respondsToSelector("requestWhenInUseAuthorization"))
        {
            locationManager.requestWhenInUseAuthorization()
        }

    }
    
    func startInitTargetImage()
    {
        targetImage.userInteractionEnabled = true
        var tapGes = UITapGestureRecognizer(target: self, action: Selector("reFreshLocation"))
        targetImage.addGestureRecognizer(tapGes)
    }
    
    func reFreshLocation()
    {
        locationManager.startUpdatingLocation()
    }
    
    // 定位用户位置坐标
    private func setCurrentUserLocation(userLocation location: CLLocationCoordinate2D) -> Void
    {
        
        var region : MKCoordinateRegion = MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: currentMap.region.span.latitudeDelta, longitudeDelta: currentMap.region.span.longitudeDelta))
        if(isMapSpanFirst)
        {
            region = MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03))
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
    func startGetSearchList(location: CLLocationCoordinate2D?) -> Void
    {
        if(isDownLoad)
        {
            return
        }
        else
        {
            isDownLoad = true
        }
        littleBoy.startAnimating()
        if(location == nil)
        {
            self.currentTable.hidden = false
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
            self?.allUserList = ZXYSearchBaseModel(dictionary: returnDic)
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
extension ZXY_NailSearchVC : MKMapViewDelegate , CLLocationManagerDelegate
{
    // MARK: - CLLocationDelegate
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if(status == CLAuthorizationStatus.AuthorizedWhenInUse)
        {
            manager.startUpdatingLocation()
        }
        else
        {
            self.showAlertEasy("提示", messageContent: "用户定位失败，请在设置中修改应用权限")
        }
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        var userLocation : CLLocation = locations.last as CLLocation
        var eventDate = userLocation.timestamp
        var interVal  = eventDate.timeIntervalSinceNow
        if(abs(interVal) < 15.0)
        {
            self.setCurrentUserLocation(userLocation: userLocation.coordinate)
            manager.stopUpdatingLocation()
            self.changeUserLocationToCityName(userLocation)
        }
    }
    
    
    // MARK: - MapViewDelegate
    func mapView(mapView: MKMapView!, regionWillChangeAnimated animated: Bool) {
        if(isDownLoad)
        {
            return
        }
        currentTable.hidden = true
        littleBoy.image = UIImage(named: "search_location")
        targetImage.hidden = true
    }
    
    func mapView(mapView: MKMapView!, regionDidChangeAnimated animated: Bool) {
        if(isDownLoad)
        {
            return
        }
        self.startInitLittleBoy()
        
        if(mapView.userLocation.location != nil)
        {
            self.changeUserLocationToCityName(mapView.userLocation.location)
        }
        else
        {
            self.changeUserLocationToCityName(CLLocation(latitude: mapView.region.center.latitude, longitude: mapView.region.center.longitude))
        }
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
                    self?.currentTable.hidden = false
                    return
                }
                if(loInfo.count > 0)
                {
                    var place: CLPlacemark = loInfo[0] as CLPlacemark
                    self?.cityName               = place.locality
                    self?.startGetSearchList(location!.coordinate)
                }
                else
                {
                    self?.currentTable.hidden = false
                }
            })
        }
        else
        {
            currentTable.hidden = false
            return
        }

    }
    
}

// MARK: tableView Delegate , DataSource and reloadData
extension ZXY_NailSearchVC : UITableViewDelegate , UITableViewDataSource , UIScrollViewDelegate
{
    func reloadCurrentTable()
    {
        if(currentTable.hidden)
        {
            currentTable.hidden = false
        }
        
        if(targetImage.hidden)
        {
            targetImage.hidden = false
        }
        currentTable.reloadData()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(ZXY_SearchArtistCellID) as ZXY_SearchArtistCell
        cell.setRateValue(indexPath.row)
        var currentUser = allUserList!.data[indexPath.row] as ZXYData
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
        var currentUser = allUserList!.data[indexPath.row] as ZXYData
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
            return allUserList!.data.count
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
}




