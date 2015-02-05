//
//  RegisterButtonCell.swift
//  KickYourAss
//
//  Created by eagle on 15/1/29.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

class RegisterButtonCell: UITableViewCell {
    
    var delegate: RegisterButtonCellDelegate?
    
    @IBOutlet private weak var doneButton: UIButton!
    
    enum CellType: Int{
        case Artist = 0
        case Normal
    }
    var currentType: CellType = .Artist{
        didSet {
            switch currentType {
            case .Artist:
                doneButton.setTitle("下一步", forState: UIControlState.Normal)
            case .Normal:
                doneButton.setTitle("确认注册", forState: UIControlState.Normal)
            }
        }
    }
    
    class var identifier: String {
        return "RegisterButtonCellIdentifier"
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func confirmButtonPressed(sender: AnyObject) {
        delegate?.registerButtonConfirmed()
    }
}

protocol RegisterButtonCellDelegate {
    func registerButtonConfirmed()
}
