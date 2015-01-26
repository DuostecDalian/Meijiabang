//
//  ZXY_BMKAnnotation.swift
//  KickYourAss
//
//  Created by 宇周 on 15/1/23.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit
import MapKit
class ZXY_BMKAnnotation: NSObject , MKAnnotation{
    
    var coordinate : CLLocationCoordinate2D
    var imgURL     : NSURL?
    

    
    init(location coordinate: CLLocationCoordinate2D , withImgURL imgURL : NSURL?)
    {
        //super.init()
        self.imgURL = imgURL
        self.coordinate = coordinate
        
    }
    
    init(location coordinate : CLLocationCoordinate2D) {
        //super.init()
        self.coordinate = coordinate
    }
    
    func setCoordinate(newCoordinate: CLLocationCoordinate2D) {
        self.coordinate = newCoordinate
    }
    
    func setImgURL(imgURL : NSURL?)
    {
        self.imgURL = imgURL
    }
}
