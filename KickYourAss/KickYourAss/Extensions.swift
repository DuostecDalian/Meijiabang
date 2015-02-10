//
//  Extensions.swift
//  KickYourAss
//
//  Created by eagle on 15/1/21.
//  Copyright (c) 2015年 Li Chaoyi. All rights reserved.
//

import Foundation

let screenWidth = UIScreen.mainScreen().bounds.size.width

extension UIColor {
    /// 主题粉红色
    class func themeRedColor() -> UIColor {
        return UIColor(red: 250.0 / 255.0, green: 100.0 / 255.0, blue: 111.0 / 255.0, alpha: 1.0)
    }
    
    /// 主题橘黄
    class func themeOrangeColor() -> UIColor {
        return UIColor(red: 251.0 / 255.0, green: 164.0 / 255.0, blue: 98.0 / 255.0, alpha: 1.0)
    }
    
}

extension UIViewController {
    func alert(message: String) {
        let alertView = UIAlertView(title: nil, message: message, delegate: nil, cancelButtonTitle: "确定")
        alertView.show()
    }
    func showHUD() {
        MBProgressHUD.showHUDAddedTo(view, animated: true)
    }
    func hideHUD() {
        MBProgressHUD.hideHUDForView(view, animated: true)
    }
    func alertNetworkFailed() {
        alert("您的网络状态不佳")
    }
    func alertLoginNeeded() {
        alert("请您先登录")
    }
    func alertWithErrorCode(code: Double) {
        alert(LCYCommon.sharedInstance.errorMessage(code))
    }
}

extension Dictionary {
    /**
    扩展可变字典
    
    :param: content 要扩充的内容
    */
    mutating func extend(content: Dictionary) {
        for (key, value) in content {
            updateValue(value, forKey: key)
        }
    }
}

extension String {
    var integerValue: Int{
        return forceBridge().integerValue
    }
    var doubleValue: Double {
        return forceBridge().doubleValue
    }
    func forceBridge() -> NSString {
        return self
    }
    /**
    将图片的相对路径转换为绝对路径
    
    :returns: 图片的绝对路径
    */
    func toAbsoluteImagePath() -> String {
        return LCYNetworking.sharedInstance.testImageURL + self
    }
    /**
    坑爹的服务器返回的所有null都是字符串“null”
    
    :returns: 如果是字符串“null”，转换成nil。
    */
    func checkNull() -> String? {
        return self == "null" ? nil : self
    }
}

extension Double {
    func decimalFormat(count: Int) -> String {
        return NSString(format: "%.\(count)f", self)
    }
}

extension UIView {
    var roundedCorner: Bool {
        set {
            if newValue {
                let radius = min(bounds.width, bounds.height) / 2.0
                layer.cornerRadius = radius
                layer.masksToBounds = true
            } else {
                layer.masksToBounds = false
                layer.cornerRadius = 0.0
            }
        }
        get {
            return layer.cornerRadius != 0
        }
    }
}
