//
//  LCYMyCommentTableViewCell.swift
//  KickYourAss
//
//  Created by eagle on 15/2/11.
//  Copyright (c) 2015年 多思科技. All rights reserved.
//

import UIKit

class LCYMyCommentTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var avatarImageView: UIImageView!
    var imagePath: String? {
        didSet {
            if let path = imagePath {
                avatarImageView.setImageWithURL(NSURL(string: path), placeholderImage: UIImage(named: "avatarPlaceholder"))
            } else {
                avatarImageView.image = UIImage(named: "avatarPlaceholder")
            }
        }
    }
    
    @IBOutlet weak var nickNameLabel: UILabel!
    
    @IBOutlet private var starImageViews: [UIImageView]!
    /// 作品积分
    var markCount: Double = 0 {
        didSet {
            for tinker in starImageViews {
                if Double(tinker.tag) > markCount {
                    tinker.image = UIImage(named: "AboutMeHeaderEmpty")
                } else {
                    tinker.image = UIImage(named: "AboutMeHeader")
                }
            }
        }
    }
    
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    
    class var identifier: String {
        return "LCYMyCommentTableViewCellIdentifier"
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
