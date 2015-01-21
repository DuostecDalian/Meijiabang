//
//  ZXY_NailSearchVC.swift
//  KickYourAss
//
//  Created by 宇周 on 15/1/20.
//  Copyright (c) 2015年 Li Chaoyi. All rights reserved.
//

import UIKit
import MapKit

class ZXY_NailSearchVC: UIViewController {
    let toHeaderMax: CGFloat = 239.0
    var locationManager : CLLocationManager!
    var isMapSpanFirst = true
    private var previousPointY : CGFloat = 0.0
    
    @IBOutlet weak var tableConsYToHeader: NSLayoutConstraint!
    @IBOutlet weak var targetImage: UIImageView!
    @IBOutlet weak var currentTable: UITableView!
    @IBOutlet weak var littleBoy: UIImageView!
    @IBOutlet weak private var currentMap: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
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
        littleBoy.animationRepeatCount = 5
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
        }
    }
    
    
    // MARK: - MapViewDelegate
    func mapView(mapView: MKMapView!, regionWillChangeAnimated animated: Bool) {
        littleBoy.image = UIImage(named: "search_location")
        targetImage.hidden = true
    }
    
    func mapView(mapView: MKMapView!, regionDidChangeAnimated animated: Bool) {
        self.startInitLittleBoy()
        targetImage.hidden = false
    }
}

extension ZXY_NailSearchVC : UITableViewDelegate , UITableViewDataSource , UIScrollViewDelegate
{
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(ZXY_SearchArtistCellID) as ZXY_SearchArtistCell
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 137
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
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
    
//    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
//        var touch : UITouch = touches.anyObject() as UITouch
//        var point           = touch.locationInView(self.currentTable)
//        if(CGRectContainsPoint(currentTable.frame, point))
//        {
//            tableConsYToHeader.constant-=3
//            self.view.layoutIfNeeded()
//        }
//        
//    }

}




