//
//  AboutMeHeaderView.swift
//  KickYourAss
//
//  Created by eagle on 15/2/6.
//  Copyright (c) 2015年 多思科技. All rights reserved.
//

import UIKit

class AboutMeHeaderView: UICollectionReusableView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        avatarImageView.roundedCorner = true
    }
        
    @IBOutlet private weak var avatarImageView: UIImageView!
    var avatarPath: String? {
        didSet {
            if let path = avatarPath {
                avatarImageView.setImageWithURL(NSURL(string: path), placeholderImage: UIImage(named: "avatarPlaceholder"))
            } else {
                avatarImageView.image = UIImage(named: "avatarPlaceholder")
            }
        }
    }
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var userInfoView: UIView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet private weak var scoreLabel: UILabel!
    @IBOutlet private var scoreImages: [UIImageView]!
    var score: Double = 0.0 {
        didSet {
            scoreLabel.text = score.decimalFormat(1) + "分"
            for tinker in scoreImages {
                if Double(tinker.tag) > score {
                    tinker.image = UIImage(named: "AboutMeHeaderEmpty")
                } else {
                    tinker.image = UIImage(named: "AboutMeHeader")
                }
            }
        }
    }
}
