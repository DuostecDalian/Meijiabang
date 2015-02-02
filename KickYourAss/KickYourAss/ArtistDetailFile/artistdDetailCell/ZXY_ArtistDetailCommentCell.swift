//
//  ZXY_ArtistDetailCommentCell.swift
//  KickYourAss
//
//  Created by 宇周 on 15/1/29.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit
let ZXY_ArtistDetailCommentCellID  = "ZXY_ArtistDetailCommentCellID"
class ZXY_ArtistDetailCommentCell: UITableViewCell {

    @IBOutlet weak var headerImg: UIImageView!
    
    @IBOutlet weak var nameLBL: UILabel!
    
    
    @IBOutlet weak var desLbl: UILabel!
    
    
    @IBOutlet weak var rateView: UIView!
    
    @IBOutlet weak var timeLbl: UILabel!
    
    @IBOutlet var rateItems: [UIImageView]!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.headerImg.layer.cornerRadius = CGRectGetWidth(self.headerImg.frame) / 2
        self.headerImg.layer.masksToBounds = true
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setRateValue(rateValue : Int)
    {
        
        var tempValue = rateValue
        if(rateValue >= rateItems.count)
        {
            tempValue = rateItems.count
        }
        for var i = 0 ; i < self.rateItems.count ; i++
        {
            if(i < tempValue)
            {
                
                var currentImgV = self.rateItems[i]
                currentImgV.image = UIImage(named: "nailartist_down")
            }
            else
            {
                var currentImgV = self.rateItems[i]
                currentImgV.image = UIImage(named: "nailartist_up")
            }
        }
    }


}
