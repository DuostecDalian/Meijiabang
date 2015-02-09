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
    *  分享主要的URL 后跟 albumID值
    */
    static let ZXY_ShareMainAPI = "http://www.meijiab.cn/admin/index.php/Home/Home/index/album_id/"
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
    
    /**
    *  获取用户详细信息
    */
    static let ZXY_UserInfoAPI = "User/another_user_Info"
    
    /**
    *  获取用户的图集API
    */
    static let ZXY_UserAlbumAPI = "UserList/my_album"
    
    /**
    *  获取用户的评价
    */
    static let ZXY_UserCommentAPI = "UserList/order_evalue"
    
    /**
    *  获取图片详情
    */
    static let ZXY_AlbumDetailAPI = "Album/album_detail"
    
    /**
    *  更改用户的关注状态
    */
    static let ZXY_ChangeStatusAtten = "User/attention"
    
    /**
    *  更改用户的点赞状态
    */
    static let ZXY_ChangeStatusFavor = "Album/album_agree"
    
    /**
    *  更改用户的收藏状态
    */
    static let ZXY_ChangeStatusCollec = "Album/album_collect"
    
    /**
    *  添加图集
    */
    static let ZXY_SubmitAlbumAPI     = "Album/add_album"
}