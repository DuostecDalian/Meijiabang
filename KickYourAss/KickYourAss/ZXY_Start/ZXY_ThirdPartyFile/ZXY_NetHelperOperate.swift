//
//  ZXY_NetHelperOperate.swift
//  KickYourAss
//
//  Created by 宇周 on 15/1/20.
//  Copyright (c) 2015年 Li Chaoyi. All rights reserved.
//

import UIKit

let _ZXY_NetInstance = ZXY_NetHelperOperate()
class ZXY_NetHelperOperate: NSObject {
    class var sharedInstance:ZXY_NetHelperOperate
    {
        return _ZXY_NetInstance
    }

    func judgeNetCanConnect(currentStatus statusBlock: ((status :AFNetworkReachabilityStatus)->Void)?) -> Void
    {
        var net : AFNetworkReachabilityManager = AFNetworkReachabilityManager.sharedManager()
        net.startMonitoring()
        net.setReachabilityStatusChangeBlock(statusBlock)
    }
}
