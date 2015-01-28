//
//  ZXY_HomeSqTitleCell.swift
//  KickYourAss
//
//  Created by 宇周 on 15/1/27.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit
let ZXY_HomeSqTitleCellID = "ZXY_HomeSqTitleCellID"
class ZXY_HomeSqTitleCell: UITableViewCell {

    @IBOutlet var titleImage: [UIImageView]!
    
    @IBOutlet var imageName: [UILabel]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
