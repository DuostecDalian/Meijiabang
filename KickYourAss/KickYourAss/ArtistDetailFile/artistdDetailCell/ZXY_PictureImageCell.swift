//
//  ZXY_PictureImageCell.swift
//  KickYourAss
//
//  Created by 宇周 on 15/2/2.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit
let ZXY_PictureImageCellID = "ZXY_PictureImageCellID"
class ZXY_PictureImageCell: UITableViewCell {

    
    @IBOutlet weak var imgBig: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
