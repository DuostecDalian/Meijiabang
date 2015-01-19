//
//  MainViewController.swift
//  KickYourAss
//
//  Created by eagle on 15/1/19.
//  Copyright (c) 2015年 Li Chaoyi. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // 搜索
        let SearchStoryboard = UIStoryboard(name: "Search", bundle: nil)
        let SearchVC = SearchStoryboard.instantiateInitialViewController() as UINavigationController
        SearchVC.tabBarItem.title = "搜索"
        addChildViewController(SearchVC)
        
        // 首页
        let HomeStoryboard = UIStoryboard(name: "Search", bundle: nil)
        let HomeVC = HomeStoryboard.instantiateInitialViewController() as UINavigationController
        HomeVC.tabBarItem.title = "首页"
        addChildViewController(HomeVC)
        
        // 美甲师
        let ArtistStoryboard = UIStoryboard(name: "Search", bundle: nil)
        let ArtistVC = ArtistStoryboard.instantiateInitialViewController() as UINavigationController
        ArtistVC.tabBarItem.title = "美甲师"
        addChildViewController(ArtistVC)
        
        // 晒美甲
        let placeHolderVC = UINavigationController()
        placeHolderVC.tabBarItem.title = "晒美甲"
        addChildViewController(placeHolderVC)
        
        // 我的
        let AboutMeStoryboard = UIStoryboard(name: "Search", bundle: nil)
        let AboutMeVC = AboutMeStoryboard.instantiateInitialViewController() as UINavigationController
        AboutMeVC.tabBarItem.title = "我的"
        addChildViewController(AboutMeVC)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
