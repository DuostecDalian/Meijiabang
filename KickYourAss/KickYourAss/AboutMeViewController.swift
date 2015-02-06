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
            } else {
                aboutMeHeader?.registerButton.hidden = false
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
    }
    
    // MARK: - Actions
    @IBAction func loginButtonPressed(sender: AnyObject) {
        println("user id  = \(LCYCommon.sharedInstance.userInfo?.userID)")
        performSegueWithIdentifier("showLogin", sender: nil)
    }
    
    func refreshHeader() {
        if let userID = LCYCommon.sharedInstance.userInfo?.userID {
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
        }
    }


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        navigationController?.navigationBar.hidden = false
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
