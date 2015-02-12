//
//  AboutMeViewController.swift
//  KickYourAss
//
//  Created by eagle on 15/1/21.
//  Copyright (c) 2015年 Li Chaoyi. All rights reserved.
//

import UIKit

class AboutMeViewController: UICollectionViewController {
    
    
    private weak var aboutMeHeader: AboutMeHeaderView?
    
    private var userInfo: CYMJUserInfoData? {
        didSet {
            if let userInfo = userInfo {
                aboutMeHeader?.registerButton.hidden = true
                aboutMeHeader?.userInfoView.hidden = false
                aboutMeHeader?.nickNameLabel.text = userInfo.nickName.checkNull()
                aboutMeHeader?.score = userInfo.score.forceBridge().doubleValue
                aboutMeHeader?.avatarPath = userInfo.headImage.toAbsoluteImagePath()
            } else {
                aboutMeHeader?.registerButton.hidden = false
                aboutMeHeader?.userInfoView.hidden = true
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
//        self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
        navigationItem.title = "我的"
        
        navigationController?.interactivePopGestureRecognizer.enabled = false
        
        refreshHeader()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.hidden = true
        navigationController?.toolbarHidden = true
        navigationController?.navigationBar.translucent = true
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if LCYCommon.sharedInstance.userInfo != nil {
            aboutMeHeader?.registerButton.hidden = true
        }
    }
    
    // MARK: - Actions
    @IBAction func loginButtonPressed(sender: AnyObject) {
        println("user id  = \(LCYCommon.sharedInstance.userInfo?.userID)")
        performSegueWithIdentifier("showLogin", sender: nil)
    }
    
    func refreshHeader() {
        if let userID = LCYCommon.sharedInstance.userInfo?.userID {
            aboutMeHeader?.registerButton.hidden = true
            let parameter = [
                "user_id" : userID
            ]
            LCYNetworking.sharedInstance.POST(
                Api: LCYNetworking.LCYApi.UserInfo,
                parameters: parameter,
                success: { [weak self](object) -> Void in
                    let retrieved = CYMJUserInfoBase.modelObjectWithDictionary(object)
                    if retrieved.result == 1000 {
                        // 正确
                        self?.userInfo = retrieved.data
                    } else {
                        self?.alert(LCYCommon.sharedInstance.errorMessage(retrieved.result))
                    }
                    return
            }, fail: { [weak self]() -> Void in
                self?.alertNetworkFailed()
                return
            })
        } else {
            userInfo = nil
        }
    }


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        navigationController?.navigationBar.hidden = false
        if let identifier = segue.identifier {
            switch identifier {
            case "showProfile":
                let destination = segue.destinationViewController as ICYProfileViewController
                destination.userInfo = userInfo
            case "showSetting":
                let destination = segue.destinationViewController as SettingViewController
                destination.userInfo = userInfo
            case "showCare":
                let destination = segue.destinationViewController as LCYCareViewController
                destination.iCareFlag = sender as? Bool ?? true
            default:
                break
            }
        }
    }


    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        return 9
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(AboutMeButtonCell.identifier, forIndexPath: indexPath) as AboutMeButtonCell
    
        // Configure the cell
        cell.currentType = AboutMeButtonCell.AboutMeButtonCellType(rawValue: indexPath.row + 1)!
    
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let reusableView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "aboutMeHeaderCell", forIndexPath: indexPath) as AboutMeHeaderView
        aboutMeHeader = reusableView
        return reusableView
    }

    // MARK: UICollectionViewDelegate
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if LCYCommon.sharedInstance.userInfo == nil {
            alertLoginNeeded()
            return
        }
        switch indexPath.row {
        case 0:
            performSegueWithIdentifier("showCare", sender: true)
        case 1:
            performSegueWithIdentifier("showCare", sender: false)
        case 3:
            let storyBoard = UIStoryboard(name: "ArtistDetailStoryBoard", bundle: nil)
            let collection = storyBoard.instantiateViewControllerWithIdentifier(ZXY_ArtistDetailWorksColleVCID) as ZXY_ArtistDetailWorksColleVC
            collection.setCurrentUserID(LCYCommon.sharedInstance.userInfo!.userID)
            collection.hidesBottomBarWhenPushed = true
            collection.navigationItem.title = "我的图集"
            navigationController?.navigationBar.translucent = false
            navigationController?.navigationBar.hidden = false
            navigationController?.pushViewController(collection, animated: true)
        case 4:
            performSegueWithIdentifier("showOrder", sender: nil)
        case 5:
            performSegueWithIdentifier("showComment", sender: nil)
        case 7:
            if let info = LCYCommon.sharedInstance.userInfo {
                if userInfo != nil {
                    performSegueWithIdentifier("showProfile", sender: nil)
                } else {
                    alert("未能获取用户数据")
                }
            } else {
                alertLoginNeeded()
            }
        case 8:
            // 设置
            if LCYCommon.sharedInstance.userInfo != nil {
                if userInfo != nil {
                    performSegueWithIdentifier("showSetting", sender: nil)
                } else {
                    alert("未能获取用户数据")
                }
            } else {
                alertLoginNeeded()
            }
        default:
            break
        }
    }

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}

extension AboutMeViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: screenWidth / 3.0, height: screenWidth / 3.0)
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: screenWidth, height: screenWidth / 320.0 * 200.0)
    }
}
