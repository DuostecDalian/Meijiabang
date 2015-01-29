//
//  ZXY_ArtistListCell.swift
//  KickYourAss
//
//  Created by 宇周 on 15/1/28.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit
let ZXY_ArtistListCellID = "ZXY_ArtistListCellID"
class ZXY_ArtistListCell: UITableViewCell {

    
    @IBOutlet weak var nameLbl: UILabel!
    
    @IBOutlet weak var numOfArt: UILabel!
    
    @IBOutlet weak var isArtistLbl: UILabel!
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var profileBack: UIImageView!
    
    @IBOutlet weak var evaluateView: UIView!
    
    @IBOutlet var scoreImages: [UIImageView]!
    
    @IBOutlet weak var likeNumLbl: UILabel!
    
    @IBOutlet weak var distanceLbl: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setHeadImageURL(url : NSURL?)
    {
        var randomColor = ZXY_AllColor().startRandomColor()
        
        profileImage.image = UIImage(named: "search_personCenter")
        
        profileImage.layer.cornerRadius = CGRectGetWidth(profileImage.frame) / 2
        profileBack.layer.cornerRadius  = CGRectGetWidth(profileBack.frame) / 2
        isArtistLbl.layer.cornerRadius  = CGRectGetWidth(isArtistLbl.frame) / 2
        
        profileImage.layer.masksToBounds = true
        profileBack.layer.masksToBounds  = true
        isArtistLbl.layer.masksToBounds  = true
        
        profileBack.backgroundColor = randomColor
        isArtistLbl.backgroundColor = randomColor
        self.profileImage.setImageWithURL(url)
    }
    
    func setRateValue(rateValue : Int)
    {
        
        var tempValue = rateValue
        if(rateValue >= scoreImages.count)
        {
            tempValue = scoreImages.count
        }
        for var i = 0 ; i < self.scoreImages.count ; i++
        {
            if(i < tempValue)
            {
                
                var currentImgV = self.scoreImages[i]
                currentImgV.image = UIImage(named: "nailartist_down")
            }
            else
            {
                var currentImgV = self.scoreImages[i]
                currentImgV.image = UIImage(named: "nailartist_up")
            }
        }
    }


}
