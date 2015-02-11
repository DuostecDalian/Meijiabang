//
//  LCYGeoManager.swift
//  KickYourAss
//
//  Created by eagle on 15/2/10.
//  Copyright (c) 2015年 多思科技. All rights reserved.
//
import CoreLocation

class LCYGeoManager: NSObject {
    
    override init() {
        super.init()
    }
    
    private var successCalled = false
    typealias locationSuccess = ((location: CLLocation) -> Void)?
    typealias locationFail = (() -> Void)?
    private var locationSuccessBlock: locationSuccess
    private var locationFailBlock: locationFail
    private var locationManager: CLLocationManager?
    func getLocation(success: locationSuccess, fail: locationFail) {
        successCalled = false
        locationSuccessBlock = success
        locationFailBlock = fail
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager!.delegate = self
            if locationManager!.respondsToSelector("requestWhenInUseAuthorization") {
                locationManager!.requestWhenInUseAuthorization()
            }
            locationManager!.startUpdatingLocation()
        } else {
            fail?()
        }
    }
    
    func distanceFrom(location: CLLocation?, toLatitude: CLLocationDegrees, toLongitude: CLLocationDegrees) -> CLLocationDistance{
        if location == nil {
            return -1
        }
        if abs(toLatitude) < 0.001 && abs(toLongitude) < 0.001 {
            return -1
        }
        let destination = CLLocation(latitude: toLatitude, longitude: toLongitude)
        return destination.distanceFromLocation(location)
    }
}

extension LCYGeoManager: CLLocationManagerDelegate {
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
//        println("updating---->")
        if let location = (locations.first as? CLLocation) {
            manager.stopUpdatingLocation()
            if !successCalled {
                successCalled = true
                locationSuccessBlock?(location: location)
            }
        } else {
            locationFailBlock?()
        }
    }
}

extension CLLocationDistance {
    func toKM() -> String {
        if self < 0 {
            return "未知"
        }else if self < 100.0 {
            return "不到100m"
        } else {
            return "\((self / 1000.0).decimalFormat(1))km"
        }
    }
}
