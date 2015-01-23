//
//  ZXY_SearchArtistCellTableViewCell.swift
//  KickYourAss
//
//  Created by 宇周 on 15/1/20.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit
let ZXY_SearchArtistCellID = "ZXY_SearchArtistCellID"
class ZXY_SearchArtistCell: UITableViewCell {

    @IBOutlet weak var userProfile: UIImageView!
    @IBOutlet weak var userProfileEdge: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var favoriteBtn: UIButton!
    @IBOutlet weak var distanceLbl: UILabel!
    
    @IBOutlet weak var rateView: UIView!
    @IBOutlet var ratingItems: [UIImageView]!
    
    @IBOutlet weak var userArtPhotoView: UIView!
    @IBOutlet var userArtPhotoItems: [UIImageView]!
    
    @IBOutlet weak var conerLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layerCustomerViewCorner(userProfile, cornerValue: CGRectGetWidth(userProfile.frame)/2)
        self.layerCustomerViewCorner(userProfileEdge, cornerValue: CGRectGetWidth(userProfileEdge.frame)/2)
        self.layerCustomerViewCorner(conerLbl, cornerValue: CGRectGetWidth(conerLbl.frame)/2)
        self.layerCustomerVCornerBold(favoriteBtn, cornerValue: 5, borderWidth: 1, borderColor:ZXY_AllColor.SEARCH_RED_COLOR)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setRateValue(rateValue : Int)
    {
       
        var tempValue = rateValue
        if(rateValue >= ratingItems.count)
        {
            tempValue = ratingItems.count
        }
        for var i = 0 ; i < self.ratingItems.count ; i++
        {
            if(i < tempValue)
            {
                UIControlState.Disabled
                var currentImgV = self.ratingItems[i]
                currentImgV.image = UIImage(named: "nailartist_down")
            }
            else
            {
                var currentImgV = self.ratingItems[i]
                currentImgV.image = UIImage(named: "nailartist_up")
            }
        }
    }
    
    func setArtsImage(imagesInfo : [ZXYImage]) -> Void
    {
        var imageURLCount : Int = imagesInfo.count
        if(imageURLCount > 3)
        {
            imageURLCount = 3
        }
        for var i = 0 ;i < imageURLCount ; i++
        {
            var currentImageV = userArtPhotoItems[i]
            var currentImageInfo = imagesInfo[i]
            var imageURL = ZXY_ALLApi.ZXY_MainAPIImage + currentImageInfo.cutPath
            currentImageV.setImageWithURL(NSURL(string: imageURL))
        }
        for var i = 0 ; i < 3; i++
        {
            if (i >= imageURLCount)
            {
                var currentImageV = userArtPhotoItems[i]
                currentImageV.image = nil
            }
        }
    }

}

// MARK: layer圆角相关
extension ZXY_SearchArtistCell
{
    func layerCustomerViewCorner(customerV : UIView , cornerValue: CGFloat) -> Void
    {
        
        customerV.layer.cornerRadius  = cornerValue
        customerV.layer.masksToBounds = true
    }
    
    func layerCustomerVCornerBold(customerV : UIView , cornerValue: CGFloat , borderWidth: CGFloat , borderColor: UIColor)
    {
        customerV.layer.cornerRadius  = cornerValue
        customerV.layer.masksToBounds = true
        
        customerV.layer.borderWidth = borderWidth
        customerV.layer.borderColor = borderColor.CGColor
    }
}
