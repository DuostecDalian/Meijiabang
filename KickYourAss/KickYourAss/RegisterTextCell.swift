//
//  RegisterTextCell.swift
//  KickYourAss
//
//  Created by eagle on 15/1/29.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

class RegisterTextCell: UITableViewCell {
    
    
    @IBOutlet private weak var icyImageView: UIImageView!
    @IBOutlet weak var icyTextField: UITextField!
    enum RegisterTextCellType: Int{
        case PhoneNumber        = 0
        case Password
        case ConfirmPassword
    }
    var currentType: RegisterTextCellType = .PhoneNumber {
        didSet {
            switch currentType {
            case .PhoneNumber:
                icyImageView.image = UIImage(named: "loginUser")
                icyTextField.secureTextEntry = false
                icyTextField.placeholder = "输入手机号"
                icyTextField.keyboardType = UIKeyboardType.NumberPad
            case .Password:
                icyImageView.image = UIImage(named: "loginPassword")
                icyTextField.secureTextEntry = true
                icyTextField.placeholder = "输入密码"
                icyTextField.keyboardType = UIKeyboardType.ASCIICapable
            case .ConfirmPassword:
                icyImageView.image = UIImage(named: "loginConfirmPassword")
                icyTextField.secureTextEntry = true
                icyTextField.placeholder = "确认密码"
                icyTextField.keyboardType = UIKeyboardType.ASCIICapable
            }
        }
    }
    
    class var identifier: String {
        return "RegisterTextCellIdentifier"
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
