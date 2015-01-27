//
//  ZXY_LocationRelative.swift
//  KickYourAss
//
//  Created by 宇周 on 15/1/26.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit
import MapKit

private let _locationR = ZXY_LocationRelative()
class ZXY_LocationRelative: NSObject {
    class var  sharedInstance: ZXY_LocationRelative
    {
        return _locationR
    }
}

extension ZXY_LocationRelative
{
    func gpsToBD(gpsCoor: CLLocationCoordinate2D) -> CLLocationCoordinate2D
    {
        var BDCoorBase = BMKConvertBaiduCoorFrom(gpsCoor, BMK_COORDTYPE_GPS)
        var BDCoorDe   = BMKCoorDictionaryDecode(BDCoorBase)
        return BDCoorDe
    }
    
//    func bdToGPS(bdCoor : CLLocationCoordinate2D) -> CLLocationCoordinate2D
//    {
//        
//    }
}
