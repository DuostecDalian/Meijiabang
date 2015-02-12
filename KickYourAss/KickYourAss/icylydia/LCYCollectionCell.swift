//
//  LCYCollectionCell.swift
//  KickYourAss
//
//  Created by eagle on 15/2/12.
//  Copyright (c) 2015年 多思科技. All rights reserved.
//

import UIKit

class LCYCollectionCell: UICollectionViewCell {
    
    @IBOutlet private weak var icyImageView: UIImageView!
    var imagePath: String? {
        didSet {
            if let path = imagePath {
                icyImageView.setImageWithURL(NSURL(string: path), placeholderImage: UIImage(named: "avatarPlaceholder"))
            } else {
                icyImageView.image = UIImage(named: "avatarPlaceholder")
            }
        }
    }
    
    @IBOutlet weak var upNumberLabel: UILabel!
    
    @IBOutlet weak var icyTimeLabel: UILabel!
    
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet private weak var avatarImageView: UIImageView!
    var avatarImagePath: String? {
        didSet {
            if let path = avatarImagePath {
                avatarImageView.setImageWithURL(NSURL(string: path), placeholderImage: UIImage(named: "avatarPlaceholder"))
            } else {
                avatarImageView.image = UIImage(named: "avatarPlaceholder")
            }
        }
    }
    
    @IBOutlet weak var authorNameLabel: UILabel!
    
    @IBOutlet private weak var colorLineView: UIView!
    var lineColor: UIColor? {
        didSet {
            colorLineView.backgroundColor = lineColor
        }
    }
    
    
    @IBOutlet var sepratorHeights: [NSLayoutConstraint]!
    
    class var identifier: String {
        return "LCYCollectionCellIdentifier"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        avatarImageView.roundedCorner = true
        colorLineView.roundedCorner = true
        for tinker in sepratorHeights {
            tinker.constant = 1.0 / UIScreen.mainScreen().scale
        }
    }
}
