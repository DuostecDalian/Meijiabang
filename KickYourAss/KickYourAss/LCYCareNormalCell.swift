//
//  LCYCareNormalCell.swift
//  KickYourAss
//
//  Created by eagle on 15/2/10.
//  Copyright (c) 2015年 多思科技. All rights reserved.
//

import UIKit

class LCYCareNormalCell: UITableViewCell {
    
    /// 昵称
    @IBOutlet weak var nickNameLabel: UILabel!
    
    /// 图集
    @IBOutlet weak var albumLabel: UILabel!
    /// 关注
    @IBOutlet weak var careLabel: UILabel!
    /// 完成订单
    @IBOutlet weak var completedOrder: UILabel!
    
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
        return "LCYCareNormalCellIdentifier"
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
