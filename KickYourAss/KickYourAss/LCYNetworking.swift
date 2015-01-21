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
    }
    
    let testBaseURL = "http://www.meijiab.cn/test/index.php/Api/"
	
    class var sharedInstance: LCYNetworking {
        struct Singleton {
            static let instance = LCYNetworking()
        }
        return Singleton.instance
    }
    
    func POST(
        Api: LCYApi,
        parameters: [String: AnyObject],
        success: ((object: NSDictionary) -> Void)?,
        fail: (() -> Void)?
        ) {
            let manager = AFHTTPRequestOperationManager()
            manager.responseSerializer = AFJSONResponseSerializer()
            let absoluteURL = testBaseURL + Api.rawValue
            println("Request: \(absoluteURL)\nwith parameters: \(parameters)")
            
            let date = NSDate()
            let timeStamp = "\(Int(date.timeIntervalSince1970))"
            let secret = CC_MD5()
            
            manager.POST(absoluteURL, parameters: parameters, success: { (operation, object) -> Void in
                if let success = success {
                    success(object: object as NSDictionary)
                }
            }) { (operation, error) -> Void in
                if let fail = fail {
                    fail()
                }
            }
    }
}
