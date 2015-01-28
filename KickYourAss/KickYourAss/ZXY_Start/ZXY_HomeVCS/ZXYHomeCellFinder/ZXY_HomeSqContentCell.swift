//
//  ZXY_HomeSqContentCell.swift
//  KickYourAss
//
//  Created by 宇周 on 15/1/27.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit
let ZXY_HomeSqContentCellID = "ZXY_HomeSqContentCellID"
class ZXY_HomeSqContentCell: UITableViewCell {

    
    @IBOutlet weak var titleImage: UIImageView!
    
    @IBOutlet weak var timeLbl: UILabel!
    
    @IBOutlet weak var desLbl: UILabel!
    
    @IBOutlet weak var favNumLbl: UILabel!
    
    @IBOutlet weak var starNumLbl: UILabel!
    
    @IBOutlet weak var backImg: UIImageView!
    
    @IBOutlet weak var profileImg: UIImageView!
    
    @IBOutlet weak var artistNameLbl: UILabel!
    
    @IBOutlet weak var isArtistLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUserProfile(profileURL : NSURL?)
    {
        var randomColor : UIColor = ZXY_AllColor().startRandomColor()
        self.profileImg.image = UIImage(named: "search_personCenter")
        
        
        self.profileImg.layer.cornerRadius = CGRectGetWidth(self.profileImg.frame) / 2
        self.backImg.layer.cornerRadius    = CGRectGetWidth(self.backImg.frame) / 2
        
        self.backImg.backgroundColor = randomColor
        
        self.isArtistLbl.layer.cornerRadius = CGRectGetWidth(self.isArtistLbl.frame) / 2
        
        self.profileImg.layer.masksToBounds = true
        self.backImg.layer.masksToBounds    = true
        self.isArtistLbl.layer.masksToBounds = true
        if(profileURL == nil)
        {
            return
        }
        self.profileImg.setImageWithURL(profileURL)
        
    }

}
