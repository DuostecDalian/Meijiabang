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
        self.delegate = self
        // Do any additional setup after loading the view.
        
        // 搜索
        let SearchStoryboard = UIStoryboard(name: "Search", bundle: nil)
        let SearchVC = SearchStoryboard.instantiateInitialViewController() as UINavigationController
       
        
        // 首页
        let HomeStoryboard = UIStoryboard(name: "Home", bundle: nil)
        let HomeVC = HomeStoryboard.instantiateInitialViewController() as UINavigationController
        
        
        // 美甲师
        let ArtistStoryboard = UIStoryboard(name: "Artist", bundle: nil)
        let ArtistVC = ArtistStoryboard.instantiateInitialViewController() as UINavigationController
       
        
        // 晒美甲
        let placeHolderVC = UINavigationController()
        
        
        // 我的
        let AboutMeStoryboard = UIStoryboard(name: "AboutMe", bundle: nil)
        let AboutMeVC = AboutMeStoryboard.instantiateInitialViewController() as UINavigationController
        
        self.setViewControllers([SearchVC,HomeVC,ArtistVC,placeHolderVC,AboutMeVC], animated: false)
        let itemPlist: NSArray! = NSArray(contentsOfFile: NSBundle.mainBundle().pathForResource("HomeItemsPList", ofType: "plist")!)
        self.tabBar.selectedImageTintColor = UIColor(red: 249.0/255.0, green: 97.0/255.0, blue: 104.0/255.0, alpha: 1)
        
        for var i = 0 ; i < self.tabBar.items?.count ; i++
        {
            var item : UITabBarItem = self.tabBar.items![i] as UITabBarItem
            var fileItemDic : Dictionary<String,String>  = itemPlist[i] as Dictionary<String,String>
            item.title = fileItemDic["itemName"]
            item.selectedImage = UIImage(named: fileItemDic["itemImage"]!)
        
            item.image = UIImage(named: fileItemDic["itemUpImage"]!)
            //item.image         = UIImage(named: fileItemDic[""]))
        }
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

extension MainViewController : UITabBarControllerDelegate , UITabBarDelegate
{
    func tabBarController(tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool {
        if(viewController == (tabBarController.viewControllers![3] as UIViewController))
        {
            return false
        }
        else
        {
            return true
        }
    }
    
    func tabBarController(tabBarController: UITabBarController, didSelectViewController viewController: UIViewController) {
         if(viewController == (tabBarController.viewControllers![3] as UIViewController))
         {
            self.showAlertEasy("", messageContent: "哈哈 ")
        }
    }
}
