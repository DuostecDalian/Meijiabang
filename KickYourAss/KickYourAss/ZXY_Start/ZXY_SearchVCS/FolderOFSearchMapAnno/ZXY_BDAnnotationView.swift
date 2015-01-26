//
//  ZXY_BDAnnotationView.swift
//  KickYourAss
//
//  Created by 宇周 on 15/1/23.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

class ZXY_BDAnnotationView: BMKAnnotationView {

    let arrowHeitht : CGFloat = 10
    var titleImg : UIImageView = UIImageView(frame: CGRectMake(5, 5, 60, 60))
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
    }
    
    override init(annotation: BMKAnnotation!, reuseIdentifier: String!) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        self.frame = CGRectMake(0, 0, 80, 80)
        titleImg.layer.cornerRadius  = 30
        titleImg.layer.masksToBounds = true
        self.backgroundColor = UIColor.whiteColor()
        self.addSubview(titleImg)
        self.drawArrowImage()
        
    }
    
    
    func drawArrowImage() -> Void
    {
        var frame = self.bounds
        var maxX = CGRectGetMaxX(frame)
        var minX = CGRectGetMinX(frame)
        var midX = CGRectGetMidX(frame)
        
        var minY = CGRectGetMinY(frame)
        var maxY = CGRectGetMaxY(frame) - arrowHeitht
        
        var context : CGContextRef = UIGraphicsGetCurrentContext()
        CGContextMoveToPoint(context, midX - arrowHeitht / 2 , maxY)
        CGContextAddArcToPoint(context, midX, maxY, midX + arrowHeitht / 2, maxY, 40)
        CGContextAddLineToPoint(context, midX, maxY + arrowHeitht)
        CGContextAddLineToPoint(context, midX - arrowHeitht / 2, maxY)
        CGContextClosePath(context)
        
    }
    
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
