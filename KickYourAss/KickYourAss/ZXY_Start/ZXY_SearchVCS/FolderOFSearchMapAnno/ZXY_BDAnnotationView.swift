//
//  ZXY_BDAnnotationView.swift
//  KickYourAss
//
//  Created by 宇周 on 15/1/23.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

class ZXY_BDAnnotationView: BMKAnnotationView {

    var titleImg : UIImageView = UIImageView(frame: CGRectMake(0, 0, 60, 60))
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
    }
    
    override init(annotation: BMKAnnotation!, reuseIdentifier: String!) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
    }
    
    
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
