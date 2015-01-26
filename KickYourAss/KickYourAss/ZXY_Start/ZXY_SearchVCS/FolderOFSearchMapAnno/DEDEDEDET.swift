//
//  DEDEDEDET.swift
//  KickYourAss
//
//  Created by 宇周 on 15/1/23.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit
import MapKit
class DEDEDEDET: NSObject , MKAnnotation{
    
    var coordinate : CLLocationCoordinate2D
    func setCoordinate(newCoordinate: CLLocationCoordinate2D) {
        
    }
    
    init(location coordinate: CLLocationCoordinate2D)
    {
        self.coordinate = coordinate
        super.init()
    }

    
    
}
