//
//  ZXY_AllPreDefine.swift
//  ZXYPrettysHealth
//
//  Created by 宇周 on 14/12/12.
//  Copyright (c) 2014年 宇周. All rights reserved.
//

import Foundation
import UIKit
struct ZXY_AllColor {
    /**
    *  主色系粉红色
    */
    static let SEARCH_RED_COLOR : UIColor = UIColor(red: 249/255.0, green: 97/255.0, blue: 104.0/255.0, alpha: 1)
    
    
    /// 广场section 头部的灰色
    static let SQURE_GRAY_COLOR : UIColor = UIColor(red: 234/255.0, green: 234/255.0, blue: 234/255.0, alpha: 1)
    func startRandomColor() -> UIColor
    {
        var randomNum = random() % 5
        switch randomNum
        {
        case 0:
            return UIColor.greenColor()
        case 1:
            return UIColor.redColor()
        case 2:
            return UIColor.orangeColor()
        case 3:
            return UIColor.greenColor()
        case 4:
            return UIColor.purpleColor()
        default:
            return UIColor.greenColor()
        }

    }
}