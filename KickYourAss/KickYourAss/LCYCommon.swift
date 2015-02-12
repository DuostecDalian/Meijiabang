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
    
    private lazy var orderStatusMap: [String: String] = {
        let mapFile = NSBundle.mainBundle().pathForResource("OrderStatus", ofType: "plist")!
        return NSDictionary(contentsOfFile: mapFile) as [String: String]
        }()
    
    enum UserDefaultKeys: String {
        case UserID = "kDefaultUserID"
        case NickName = "kDefaultNickname"
        case Role = "kDefaultRole"
        case UserDetail = "kDefaultUserDetail"
    }
    
    class var sharedInstance: LCYCommon {
        struct Singleton {
            static let instance = LCYCommon()
        }
        return Singleton.instance
    }
    
    class LCYUser {
        let userID: String
        let nickName: String?
        let role: String
        init(userID: String, nickName: String?, role: String) {
            self.userID = userID
            self.nickName = nickName
            self.role = role
        }
    }
    
    var userInfo: LCYUser? {
        let userID = userDefault.objectForKey(UserDefaultKeys.UserID.rawValue) as? String
        let nickName = userDefault.objectForKey(UserDefaultKeys.NickName.rawValue) as? String
        let role = userDefault.objectForKey(UserDefaultKeys.Role.rawValue) as? String
        if userID != nil && role != nil {
            return LCYUser(userID: userID!, nickName: nickName, role: role!)
        } else {
            return nil
        }
    }
    //    var userID: String? {
    //        return userDefault.objectForKey(UserDefaultKeys.UserID.rawValue) as? String
    //    }
    
    private var userDetail: CYMJUserInfoData? {
        if let info = userDefault.objectForKey(UserDefaultKeys.UserDetail.rawValue) as? NSDictionary {
            return CYMJUserInfoData.modelObjectWithDictionary(info)
        } else {
            return nil
        }
    }
    typealias UserDetailSuccessBlock = ((userDetail: CYMJUserInfoData) -> Void)?
    typealias UserDetailFailBlock = (() -> Void)?
    func getUserDetailInfo(successBlock: UserDetailSuccessBlock, failBlock: UserDetailFailBlock) {
        if let userDetail = userDetail {
            successBlock?(userDetail: userDetail)
        } else {
            if let userID = userInfo?.userID {
                let parameter = ["user_id": userID]
                LCYNetworking.sharedInstance.POST(
                    Api: LCYNetworking.LCYApi.UserInfo,
                    parameters: parameter,
                    success: { [unowned self](object) -> Void in
                        let retrieved = CYMJUserInfoBase.modelObjectWithDictionary(object)
                        if retrieved.result == 1000 {
                            self.setUserDetailInfo(retrieved.data)
                            successBlock?(userDetail: retrieved.data)
                        } else {
                            failBlock?()
                        }
                        return
                    }, fail: { () -> Void in
                        failBlock?()
                        return
                })
            } else {
                failBlock?()
            }
        }
    }
    
    func setUserDetailInfo(info: CYMJUserInfoData?) {
        if let info = info {
            userDefault.setObject(info.dictionaryRepresentation(), forKey: UserDefaultKeys.UserDetail.rawValue)
        } else {
            userDefault.removeObjectForKey(UserDefaultKeys.UserDetail.rawValue)
        }
        userDefault.synchronize()
    }
    
    func login(userID: String?, nickName: String?, role: String?) {
        userDefault.setObject(userID, forKey: UserDefaultKeys.UserID.rawValue)
        userDefault.setObject(nickName, forKey: UserDefaultKeys.NickName.rawValue)
        userDefault.setObject(role, forKey: UserDefaultKeys.Role.rawValue)
        userDefault.synchronize()
    }
    
    func logout() {
        //        userDefault.setNilValueForKey(UserDefaultKeys.UserID.rawValue)
        userDefault.removeObjectForKey(UserDefaultKeys.UserID.rawValue)
        userDefault.removeObjectForKey(UserDefaultKeys.NickName.rawValue)
        userDefault.removeObjectForKey(UserDefaultKeys.Role.rawValue)
        setUserDetailInfo(nil)
        userDefault.synchronize()
    }
    
    func errorMessage(code: Int?) -> String {
        if let code = code {
            return errorMap[code] ?? "未知错误😓"
        } else {
            return "未知错误😓"
        }
    }
    
    func errorMessage(code: Double?) -> String {
        return errorMessage(code != nil ? Int(code!) : nil)
    }
    
    func orderStatus(code: String) -> String {
        return orderStatusMap[code] ?? "未知状态😓"
    }
}

enum Gender: Int {
    case Male = 1
    case Female = 2
    case Unknown = 9
}
