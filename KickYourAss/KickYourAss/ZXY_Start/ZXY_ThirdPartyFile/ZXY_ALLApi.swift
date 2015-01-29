//
//  ZXY_ALLApi.swift
//  KickYourAss
//
//  Created by 宇周 on 15/1/21.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import Foundation
/**
*  周效宇的API接口
*/
struct ZXY_ALLApi
{
    /**
    *  用于获取非图片数据的主要API
    */
    static let ZXY_MainAPI      = "http://www.meijiab.cn/admin/index.php/Api/"
    
    /**
    *  用于获取图片的主要HOST_Image_API
    */
    static let ZXY_MainAPIImage = "http://www.meijiab.cn/admin/"
    
    /**
    *  搜索页面 ： 用户列表相关API
    */
    static let ZXY_SearchListAPI = "UserList/user_list"
    
    /**
    *  获取首页部分最热的API
    */
    static let ZXY_AlbumHotAPI              = "Album/album_hot"
    
    /**
    *  获取广场数据 API
    */
    static let ZXY_AlbumSquAPI              = "Album/album_square"
    
    /**
    *  美甲师列表接口API
    */
    static let ZXY_UserListAPI              = "UserList/tech_list"
}