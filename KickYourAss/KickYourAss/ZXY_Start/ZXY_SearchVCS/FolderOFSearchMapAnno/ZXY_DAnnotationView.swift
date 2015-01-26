//
//  ZXY_BDAnnotationView.swift
//  KickYourAss
//
//  Created by 宇周 on 15/1/23.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit
import MapKit
class ZXY_DAnnotationView: MKAnnotationView {

    private let arrowHeight : CGFloat = 10
    var titleImg : UIImageView = UIImageView(frame: CGRectMake(1, 1, 58 ,58 ))
    private var backImg : UIImageView!
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        self.drawCircleArrow()
        self.layer.shadowColor = UIColor.grayColor().CGColor
        self.layer.shadowOpacity = 1.0;
        self.layer.shadowOffset = CGSizeMake(0, 0);
        titleImg.layer.cornerRadius = 30
        titleImg.layer.masksToBounds = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override init(annotation: MKAnnotation!, reuseIdentifier: String!) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        self.frame = CGRectMake(0, 0, 60  , 70)
        self.backImg = UIImageView(frame: CGRectMake(0, 0, 60, 70))
        backImg.image = UIImage(named: "bubbleMap")
        self.addSubview(backImg)
        self.addSubview(titleImg)
        titleImg.backgroundColor = UIColor.blueColor()
        self.backgroundColor = UIColor.clearColor()
        self.layer.masksToBounds = true
        self.canShowCallout = false
    }
    
    
    func drawCircleArrow() -> Void
    {
//        var frame = self.bounds
//        var minX = CGRectGetMinX(frame)
//        var maxX = CGRectGetMaxX(frame)
//        var midX = CGRectGetMidX(frame)
//        
//        var minY = CGRectGetMinY(frame)
//        var maxY = CGRectGetMaxY(frame) - arrowHeight
//        
//        var context : CGContextRef = UIGraphicsGetCurrentContext()
//        CGContextSetStrokeColor(context, CGColorGetComponents(UIColor.redColor().CGColor))
//        CGContextSetFillColor(context, CGColorGetComponents(UIColor.whiteColor().CGColor))
//        CGContextMoveToPoint(context, midX - arrowHeight / 2, maxY)
//        CGContextAddArcToPoint(context, midX, 0, midX + arrowHeight / 2, maxY, 30)
//        
//        CGContextAddLineToPoint(context, midX, maxY + arrowHeight)
//        CGContextAddLineToPoint(context, midX - arrowHeight / 2, maxY)
//        CGContextClosePath(context);
//        CGContextStrokePath(context)
//        
//        CGContextFillPath(context);
    }
    
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
