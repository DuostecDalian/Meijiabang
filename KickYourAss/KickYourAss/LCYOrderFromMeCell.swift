//
//  LCYOrderFromMeCell.swift
//  KickYourAss
//
//  Created by eagle on 15/2/11.
//  Copyright (c) 2015年 多思科技. All rights reserved.
//

import UIKit

class LCYOrderFromMeCell: UITableViewCell {
    
    @IBOutlet weak var apTimeLabel: UILabel!
    @IBOutlet weak var cusNameLabel: UILabel!
    @IBOutlet weak var apLocationLabel: UILabel!
    
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var statusNewImage: UIImageView!
    
    var showNew: Bool = false {
        didSet {
            statusNewImage.hidden = !showNew
            statusLabel.hidden = showNew
        }
    }

    class var identifier: String {
        return "LCYOrderFromMeCellIdentifier"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
