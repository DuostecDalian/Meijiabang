//
//  ZXY_BMKAnnotation.swift
//  KickYourAss
//
//  Created by 宇周 on 15/1/23.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

class ZXY_BMKAnnotation: NSObject , BMKAnnotation{
    
    var coordinate : CLLocationCoordinate2D
    var imgURL     : NSURL?
    

    
    init(location coordinate: CLLocationCoordinate2D , withImgURL imgURL : NSURL?)
    {
        self.imgURL = imgURL
        self.coordinate = coordinate
        super.init()
    }
    
    func setCoordinate(newCoordinate: CLLocationCoordinate2D) {
        self.coordinate = newCoordinate
    }
    
    func setImgURL(imgURL : NSURL?)
    {
        self.imgURL = imgURL
    }
}
