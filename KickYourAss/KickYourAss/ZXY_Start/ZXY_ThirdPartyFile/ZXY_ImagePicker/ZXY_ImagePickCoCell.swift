//
//  ZXY_ImagePickCoCell.swift
//  KickYourAss
//
//  Created by 宇周 on 15/2/4.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

class ZXY_ImagePickCoCell: UICollectionViewCell {
    var currentImageV : UIImageView! = UIImageView()
    override var reuseIdentifier: String { return "zxy_Collection" }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init() {
        super.init()
        
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        currentImageV.contentMode = UIViewContentMode.ScaleAspectFill
        currentImageV.setTranslatesAutoresizingMaskIntoConstraints(false)
        currentImageV.backgroundColor = UIColor.redColor()
        self.addSubview(currentImageV)
        self.addConstraint(NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: currentImageV, attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: currentImageV, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: currentImageV, attribute: NSLayoutAttribute.Trailing, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: currentImageV, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 0))
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
