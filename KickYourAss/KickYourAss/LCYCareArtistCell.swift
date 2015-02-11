//
//  LCYCareArtistCell.swift
//  KickYourAss
//
//  Created by eagle on 15/2/10.
//  Copyright (c) 2015年 多思科技. All rights reserved.
//

import UIKit

class LCYCareArtistCell: UITableViewCell {
    
    /// 昵称
    @IBOutlet weak var nickNameLabel: UILabel!
    /// 作品：13
    @IBOutlet weak var artworkCountLabel: UILabel!
    /// 0.03km
    @IBOutlet weak var distanceLabel: UILabel!
    /// 点赞人数哦
    @IBOutlet weak var starCountLabel: UILabel!
    
    @IBOutlet private var markImageViews: [UIImageView]!
    /// 作品积分
    var markCount: Double = 0 {
        didSet {
            for tinker in markImageViews {
                if Double(tinker.tag) > markCount {
                    tinker.image = UIImage(named: "AboutMeHeaderEmpty")
                } else {
                    tinker.image = UIImage(named: "AboutMeHeader")
                }
            }
        }
    }
    
    @IBOutlet private weak var avatarImageView: UIImageView!
    /// 图片绝对路径
    var imagePath: String? {
        didSet {
            if let path = imagePath {
                avatarImageView.setImageWithURL(NSURL(string: path), placeholderImage: UIImage(named: "avatarPlaceholder"))
            } else {
                avatarImageView.image = UIImage(named: "avatarPlaceholder")
            }
        }
    }
    
    
    
    
    
    class var identifier: String {
        return "LCYCareArtistCellIdentifier"
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        avatarImageView.roundedCorner = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
