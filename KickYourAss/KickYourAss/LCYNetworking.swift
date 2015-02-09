//
//  LCYNetworking.swift
//  KickYourAss
//
//  Created by eagle on 15/1/21.
//  Copyright (c) 2015年 Li Chaoyi. All rights reserved.
//



class LCYNetworking {
    
    enum LCYApi: String {
        case UserLogin          = "User/login"
        case UserRegister       = "User/register"
    }
    
    let testBaseURL = "http://www.meijiab.cn/admin/index.php/Api/"
    
    class var sharedInstance: LCYNetworking {
        struct Singleton {
            static let instance = LCYNetworking()
        }
        return Singleton.instance
    }
    
    func POST(
        #Api: LCYApi,
        parameters: [String: AnyObject]?,
        success: ((object: NSDictionary) -> Void)?,
        fail: (() -> Void)?
        ) {
            let manager = AFHTTPRequestOperationManager()
            manager.responseSerializer = AFJSONResponseSerializer()
            manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/html"])
            let absoluteURL = testBaseURL + Api.rawValue
            
            // 带加密参数
            var finalParameter = parameters ?? [String: AnyObject]()
            println("Request: \(absoluteURL)\nwith parameters: \(finalParameter)")
            // 时间戳
            let timeStamp = "\(Int(NSDate().timeIntervalSince1970))"
            let secret = ("meijia" + timeStamp).md5()
            finalParameter.extend(
                [   "token": secret,
                    "timestamp": timeStamp]
            )
            manager.POST(
                absoluteURL,
                parameters: finalParameter,
                success: { (operation, object) -> Void in
                    if let success = success {
                        println("success in \(absoluteURL) ===> \(operation.responseString)")
                        success(object: object as NSDictionary)
                    }
                }) { (operation, error) -> Void in
                    if let fail = fail {
                        println("failed in \(absoluteURL) ===> \(error)")
                        fail()
                    }
            }
    }
    
    func POSTImage(
        #Api: LCYApi,
        parameters: [String: AnyObject]?,
        imageData: [NSData],
        fileKey: String,
        success: ((object: NSDictionary) -> Void)?,
        fail: (() -> Void)?
        ) {
            let manager = AFHTTPRequestOperationManager()
            manager.responseSerializer = AFJSONResponseSerializer()
            manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/html"])
            let absoluteURL = testBaseURL + Api.rawValue
            
            // 带加密参数
            var finalParameter = parameters ?? [String: AnyObject]()
            println("Request: \(absoluteURL)\nwith parameters: \(finalParameter)")
            // 时间戳
            let timeStamp = "\(Int(NSDate().timeIntervalSince1970))"
            let secret = ("meijia" + timeStamp).md5()
            finalParameter.extend(
                [   "token": secret,
                    "timestamp": timeStamp]
            )
            
            manager.POST(absoluteURL,
                parameters: finalParameter,
                constructingBodyWithBlock: { (formData) -> Void in
                    imageData.map({
                        formData.appendPartWithFileData($0, name: fileKey, fileName: "tiancailcy.jpg", mimeType: "image/jpeg")
                    })
                    return
                }, success: { (operation, object) -> Void in
                    if let success = success {
                        println("success in \(absoluteURL) ===> \(operation.responseString)")
                        success(object: object as NSDictionary)
                    }
                }) { (operation, error) -> Void in
                    if let fail = fail {
                        println("failed in \(absoluteURL) ===> \(error)")
                        fail()
                    }
            }
    }
}
