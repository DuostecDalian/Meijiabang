//
//  ZXY_AfterPickImgVC.swift
//  KickYourAss
//
//  Created by 宇周 on 15/2/5.
//  Copyright (c) 2015年 多思科技. All rights reserved.
//

import UIKit

class ZXY_AfterPickImgVC: UIViewController {

    @IBOutlet weak var currentCollectionV: UICollectionView!
    var assetsArr : [ALAsset]? = []
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setAssetArr(assArr : [ALAsset])
    {
        self.assetsArr = assArr
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
}
