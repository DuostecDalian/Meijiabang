//
//  ZXY_PictureHeaderCell.swift
//  KickYourAss
//
//  Created by 宇周 on 15/2/2.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit
let ZXY_PictureHeaderCellID = "ZXY_PictureHeaderCellID"
protocol ZXY_PictureHeaderCellDelegate : class
{
    func clickIsAttensionBtn()
}
class ZXY_PictureHeaderCell: UITableViewCell {

    @IBOutlet weak var backImg: UIImageView!
    
    @IBOutlet weak var profileImg: UIImageView!
    
    @IBOutlet weak var isArtist: UILabel!
    
    @IBOutlet weak var nameLbl: UILabel!
    
    @IBOutlet weak var albumNameLbl: UILabel!
    
    @IBOutlet weak var attenNumLbl: UILabel!
    
    @IBOutlet weak var attenBtn: UIButton!
    
    weak var delegate : ZXY_PictureHeaderCellDelegate!
    
    
    
    
    func setProfileImage(profileURL : NSURL)
    {
        self.profileImg.image = UIImage(named: "search_personCenter")
        self.profileImg.setImageWithURL(profileURL)
        var randomColor = ZXY_AllColor().startRandomColor()
        self.backImg.backgroundColor = randomColor
        self.isArtist.backgroundColor = randomColor
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.profileImg.backgroundColor = UIColor.whiteColor()
        self.backImg.layer.cornerRadius = CGRectGetWidth(self.backImg.frame) / 2
        self.profileImg.layer.cornerRadius = CGRectGetWidth(self.profileImg.frame) / 2
        self.isArtist.layer.cornerRadius   = CGRectGetWidth(self.isArtist.frame) / 2
        
        self.backImg.layer.masksToBounds    = true
        self.profileImg.layer.masksToBounds = true
        self.isArtist.layer.masksToBounds   = true
        
        attenBtn.layer.cornerRadius = 4
        attenBtn.layer.masksToBounds = true
        attenBtn.layer.borderWidth   = 1
        attenBtn.layer.borderColor   = ZXY_AllColor.SEARCH_RED_COLOR.CGColor
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    @IBAction func clickAttenBtn(sender: AnyObject) {
        self.delegate.clickIsAttensionBtn()
    }
    

}
