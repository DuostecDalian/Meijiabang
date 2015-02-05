//
//  LCYCommon.swift
//  KickYourAss
//
//  Created by eagle on 15/2/3.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

class LCYCommon {
    
    private lazy var userDefault = NSUserDefaults.standardUserDefaults()
    
    private lazy var errorMap: [Int: String] = {
        let mapFile = NSBundle.mainBundle().pathForResource("ErrorMessage", ofType: "plist")!
        let mapContent = NSDictionary(contentsOfFile: mapFile)! as [String: String]
        var newMap = [Int: String]()
        for (key, value) in mapContent {
            newMap[key.integerValue] = value
        }
        return newMap
    }()
    
    enum UserDefaultKeys: String {
        case UserID = "kDefaultUserID"
    }
    
    class var sharedInstance: LCYCommon {
        struct Singleton {
            static let instance = LCYCommon()
        }
        return Singleton.instance
    }
    
    var userID: String? {
        return userDefault.objectForKey(UserDefaultKeys.UserID.rawValue) as? String
    }
    
    func login(userID: String?) {
        userDefault.setObject(userID, forKey: UserDefaultKeys.UserID.rawValue)
        userDefault.synchronize()
    }
    
    func logout() {
        userDefault.setNilValueForKey(UserDefaultKeys.UserID.rawValue)
        userDefault.synchronize()
    }
    
    func errorMessage(code: Int?) -> String {
        if let code = code {
            return errorMap[code] ?? "未知错误😓"
        } else {
            return "未知错误😓"
        }
    }
}
