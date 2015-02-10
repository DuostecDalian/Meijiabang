//
//  ZXY_AfterPickImgVC.swift
//  KickYourAss
//
//  Created by 宇周 on 15/2/5.
//  Copyright (c) 2015年 多思科技. All rights reserved.
//

import UIKit

class ZXY_AfterPickImgVC: UIViewController {

    let maxNumOfPhoto = 1
    @IBOutlet weak var currentCollectionV: UICollectionView!
    var isBarHidden = false
    var desTxt      : UITextView?
    var assetsArr : [ALAsset]? = []
    override func viewDidLoad() {
        super.viewDidLoad()
        if(self.navigationController!.navigationBar.hidden)
        {
            isBarHidden = true
        }
        self.navigationController?.navigationBar.hidden = false
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "提交", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("submitAction"))
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func submitAction()
    {
        if(desTxt?.text.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) == 0)
        {
            self.showAlertEasy("提示", messageContent: "介绍不能为空")
            return
        }
        
        if(self.assetsArr?.count == 0)
        {
            self.showAlertEasy("提示", messageContent: "您未选择照片")
            return
        }
        
        var urlString = ZXY_ALLApi.ZXY_MainAPI + ZXY_ALLApi.ZXY_SubmitAlbumAPI
        
        var userID    = LCYCommon.sharedInstance.userInfo?.userID
        
        if(userID == nil)
        {
            var story  = UIStoryboard(name: "AboutMe", bundle: nil)
            var vc     = story.instantiateViewControllerWithIdentifier("login") as UIViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        var parameter : Dictionary<String , AnyObject?> = ["user_id": userID , "description" : desTxt?.text ]
    }
    
    func setAssetArr(assArr : [ALAsset])
    {
        self.assetsArr = assArr
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        if(isBarHidden)
        {
            self.navigationController?.navigationBar.hidden = true
        }
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

extension ZXY_AfterPickImgVC : UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout
{
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var currentRow = indexPath.row
        var currentSection = indexPath.section
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier(ZXY_PicTakeImgCellID, forIndexPath: indexPath) as ZXY_PicTakeImgCell
        if(self.assetsArr != nil)
        {
            if(currentRow < self.assetsArr!.count)
            {
                var currentAsset = self.assetsArr![currentRow]
                var cgImg        = currentAsset.thumbnail()
                cell.cellImg.image = UIImage(CGImage: cgImg.takeUnretainedValue())
            }
            else
            {
                cell.cellImg.image = UIImage(named: "rectangleAdd")
            }
            
        }
        else
        {
            cell.cellImg.image = UIImage(named: "rectangleAdd")
        }
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView
    {
        var cell = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "PicTakeInputCell", forIndexPath: indexPath) as ZXY_PicTakeInputCell
        cell.inputText.layer.cornerRadius = 4
        cell.inputText.layer.borderWidth  = 1
        cell.inputText.layer.masksToBounds = true
        cell.inputText.layer.borderColor  = ZXY_AllColor.SEARCH_RED_COLOR.CGColor
        desTxt = cell.inputText
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(self.assetsArr != nil)
        {
            return self.assetsArr!.count + 1
        }
        else
        {
            return 1
        }
        
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        var width = (self.view.frame.size.width - 40 )/4
        return CGSizeMake(width, width)

    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(5, 5, 5, 5)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: screenWidth, height: 130)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        var currentRow = indexPath.row
        
        if(self.assetsArr != nil)
        {
            if(currentRow == self.assetsArr?.count)
            {
                if(self.assetsArr?.count == maxNumOfPhoto)
                {
                    self.showAlertEasy("提示", messageContent: "最多只能选择一张图片")
                }
                else
                {
                    var story = UIStoryboard(name: "ZXYTakePic", bundle: nil)
                    var vc    = story.instantiateInitialViewController() as ZXY_PictureTakeVC
                    vc.delegate = self
                    vc.presentView()
                }
            }
            else
            {
                var currentAsset = self.assetsArr![currentRow]
                var currentpresent = currentAsset.defaultRepresentation()
                var cgIMG = currentpresent.fullResolutionImage().takeUnretainedValue()
                var img      = UIImage(CGImage: cgIMG)
                self.showItemInMain(img!)
            }
        }
        else
        {
            
        }

    }
    
    func showItemInMain(img : UIImage)
    {
        var story : UIStoryboard = UIStoryboard(name: "ZXYTakePic", bundle: nil)
        var vc    : ZXY_PickImgPictureVC = story.instantiateViewControllerWithIdentifier("pictureVCID") as ZXY_PickImgPictureVC
        vc.delegate = self
        vc.setCurrentImage(img)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ZXY_AfterPickImgVC : ZXY_PickImgPictureVCDelegate , ZXY_ImagePickerDelegate , ZXY_PictureTakeDelegate
{
    func deletePhoto() {
        assetsArr?.removeAll(keepCapacity: false)
        currentCollectionV.reloadData()
    }
    
    func clickChoosePictureBtn() {
        
        
        var zxy_imgPick = ZXY_ImagePickerTableVC()
        zxy_imgPick.setMaxNumOfSelect(1)
        zxy_imgPick.delegate = self
        zxy_imgPick.presentZXYImagePicker(self)
    }
    
    func clickTakePhotoBtn() {
        
    }
    
    func ZXY_ImagePicker(imagePicker: ZXY_ImagePickerTableVC, didFinishPicker assetArr: [ALAsset]) {
        
       for (index , value) in enumerate(assetArr)
       {
            self.assetsArr?.append(value)
        }
        
        self.currentCollectionV.reloadData()
        
    }

}
