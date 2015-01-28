//
//  ZXY_HomeMostFashionCell.swift
//  KickYourAss
//
//  Created by 宇周 on 15/1/27.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit
let ZXY_HomeMostFashionCellID = "ZXY_HomeMostFashionCellID"
class ZXY_HomeMostFashionCell: UICollectionViewCell {
    @IBOutlet weak var fashionImage: UIImageView!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var isArtist: UILabel!
    @IBOutlet weak var artistBack: UIImageView!
    @IBOutlet weak var artistProfile: UIImageView!
    @IBOutlet weak var fashionValue: UILabel!
    @IBOutlet weak var heartImage: UIImageView!
    @IBOutlet weak var fashionTime: UILabel!
    @IBOutlet weak var fashionName: UILabel!
    
    @IBOutlet weak var edgeImage: UIImageView!
    

    func setHeaderImage(imageURL : NSURL? )
    {
        self.artistProfile.image = UIImage(named: "search_personCenter")
        if(imageURL != nil)
        {
            self.artistProfile.setImageWithURL(imageURL)
        }
        else
        {
            self.artistProfile.image = UIImage(named: "search_personCenter")
        }
        var currentColor = ZXY_AllColor().startRandomColor()
        self.artistBack.backgroundColor = currentColor
        self.isArtist.backgroundColor   = currentColor
        
        self.artistBack.layer.cornerRadius = CGRectGetWidth(self.artistBack.frame) / 2
        self.isArtist.layer.cornerRadius   = CGRectGetWidth(self.isArtist.frame) / 2
        self.artistProfile.layer.cornerRadius = CGRectGetWidth(self.artistProfile.frame) / 2
        
        self.artistBack.layer.masksToBounds = true
        self.artistProfile.layer.masksToBounds = true
        self.isArtist.layer.masksToBounds      = true
        
        self.edgeImage.layer.cornerRadius = 5
        self.edgeImage.layer.masksToBounds = true
        
        self.edgeImage.backgroundColor = currentColor
    }
    
    func setArtImage(imageURL : NSURL? )
    {
        self.fashionImage.image = nil

        if(imageURL != nil )
        {
            self.fashionImage.setImageWithURL(imageURL)
        }
        else
        {
            self.fashionImage.image = nil
        }
    }
    
    
}
