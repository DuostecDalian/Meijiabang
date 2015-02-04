//
//  ZXY_ImagePickerCollectionVC.swift
//  KickYourAss
//
//  Created by 宇周 on 15/2/4.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

class ZXY_ImagePickerCollectionVC: UIViewController {
    struct Static {
        static var onceToken : dispatch_once_t = 0
    }
    
    var isFirst : Bool = true
    var currentCollection : UICollectionView = UICollectionView(frame: CGRectMake(0, 0, 0, 0), collectionViewLayout: WaterfallLayout())
    var assetGroup : ALAssetsGroup!
    var assetsArr  : [ALAsset] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentCollection.delegate   = self
        currentCollection.dataSource = self
        currentCollection.backgroundColor = UIColor.whiteColor()
        //currentCollection.setCollectionViewLayout(WaterfallLayout(), animated: false)
        self.view.addSubview(currentCollection)
        currentCollection.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.view.addConstraint(NSLayoutConstraint(item: self.view, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: currentCollection, attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.view, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: currentCollection, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.view, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: currentCollection, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.view, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: currentCollection, attribute: NSLayoutAttribute.Trailing, multiplier: 1, constant: 0))
        
        // Do any additional setup after loading the view.
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setAssetsArr(assetsArr : ALAssetsGroup)
    {
        self.assetGroup = assetsArr
        var assetEnumBlock : ALAssetsGroupEnumerationResultsBlock = {[weak self] (asset, index, stop) -> Void in
            if(asset != nil)
            {
                self?.assetsArr.append(asset)
            }
        }
        var filter : ALAssetsFilter = ALAssetsFilter.allPhotos()
        assetGroup.enumerateAssetsUsingBlock(assetEnumBlock)
        
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

extension ZXY_ImagePickerCollectionVC: UICollectionViewDataSource , UICollectionViewDelegate , WaterfallLayoutDelegate
{
    func collectionView(collectionView: UICollectionView!, layout collectionViewLayout: UICollectionViewLayout!, sizeForItemAtIndexPath indexPath: NSIndexPath!) -> CGSize {
        var currentAsset = self.assetsArr[indexPath.row]
        var cgImage      = currentAsset.aspectRatioThumbnail().takeUnretainedValue()
        var currentImg   = UIImage(CGImage: cgImage)
        var ratio        = currentImg!.size.height / currentImg!.size.width
        var imageHe      = ratio * (self.view.frame.size.width - 20)/2
        return CGSizeMake((self.view.frame.size.width - 20)/2, imageHe)
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if(isFirst)
        {
            collectionView.registerClass(ZXY_ImagePickCoCell.self, forCellWithReuseIdentifier: "zxy_Collection")
        }
        var cell : ZXY_ImagePickCoCell? = collectionView.dequeueReusableCellWithReuseIdentifier("zxy_Collection", forIndexPath: indexPath) as? ZXY_ImagePickCoCell
        if(cell == nil)
        {
            cell = ZXY_ImagePickCoCell()
            
        }
        var currentAsset = self.assetsArr[indexPath.row]
        var cgImage      = currentAsset.aspectRatioThumbnail().takeUnretainedValue()
        var currentImg   = UIImage(CGImage: cgImage)
        cell?.currentImageV.image = currentImg
        
        return cell!
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.assetsArr.count
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView!, layout collectionViewLayout: UICollectionViewLayout!, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(5, 5, 5, 5)
    }
    
}
