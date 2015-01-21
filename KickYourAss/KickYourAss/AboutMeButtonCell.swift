//
//  AboutMeButtonCell.swift
//  KickYourAss
//
//  Created by eagle on 15/1/21.
//  Copyright (c) 2015年 Li Chaoyi. All rights reserved.
//

import UIKit

enum AboutMeButtonCellType: Int {
    case 我关注的人  = 1
    case 关注我的人
    case 消息
    case 我的图集
    case 我的订单
    case 我的评价
    case 我的收藏
    case 个人信息
    case 设置
    func toString() -> String {
        switch self {
        case .我关注的人:
            return "我关注的人"
        case .关注我的人:
            return "关注我的人"
        case .消息:
            return "消息"
        case .我的图集:
            return "我的图集"
        case .我的订单:
            return "我的订单"
        case .我的评价:
            return "我的评价"
        case .我的收藏:
            return "我的收藏"
        case .个人信息:
            return "个人信息"
        case .设置:
            return "设置"
        }
    }
}

class AboutMeButtonCell: UICollectionViewCell {
    
    var currentType: AboutMeButtonCellType = .我关注的人 {
        didSet {
            icyImageView.image = UIImage(named: "AboutMe\(currentType.rawValue)")
            icyLabel.text = currentType.toString()
        }
    }
    
    @IBOutlet private weak var icyImageView: UIImageView!
    @IBOutlet private weak var icyLabel: UILabel!
    
    @IBOutlet var seprateLineWidth: [NSLayoutConstraint]!
    
    class var identifier: String {
        return "AboutMeButtonCellIdentifier"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        for oneConstraint in seprateLineWidth {
            oneConstraint.constant = 1.0 / UIScreen.mainScreen().scale
        }
    }
    
}
