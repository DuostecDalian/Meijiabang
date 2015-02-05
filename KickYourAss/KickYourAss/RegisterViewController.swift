//
//  RegisterViewController.swift
//  KickYourAss
//
//  Created by eagle on 15/1/28.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

class RegisterViewController: UITableViewController {
    
    private weak var phoneTextField: UITextField!
    private weak var passwordTextField: UITextField!
    private weak var passwordConfirmTextField: UITextField!
    
    // 界面状态
    enum RegisterStatus: Int {
        case Artist = 0
        case Normal = 1
    }
    private var currentStatus: RegisterStatus = .Artist {
        didSet {
            tableView.reloadData()
        }
    }
    @IBAction func segmentValueChanged(sender: UISegmentedControl) {
        currentStatus = RegisterStatus(rawValue: sender.selectedSegmentIndex)!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
        
        let flexRight = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        let midButton = UIBarButtonItem(title: "注册协议", style: UIBarButtonItemStyle.Plain, target: self, action: "midButtonPressed:")
        let flexLeft = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        
        setToolbarItems([flexRight, midButton, flexLeft], animated: false)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.setToolbarHidden(false, animated: false)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.toolbarHidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions
    func midButtonPressed(sender: AnyObject) {
        performSegueWithIdentifier("showWeb", sender: nil)
    }
    
    private func register() {
        func checkValid() -> Bool {
            // 验证电话号码
            let phoneNumber = phoneTextField.text
            let regx = "^1[3458]\\d{9}$"
            let predicate = NSPredicate(format: "SELF MATCHES %@", argumentArray: [regx])
            if !predicate.evaluateWithObject(phoneNumber) {
                alert("请输入正确的手机号码")
                return false
            }
            // 验证密码
            let password = passwordTextField.text
            if countElements(password) < 6 {
                alert("请输入至少6位的密码")
                return false
            }
            // 密码确认
            let confirm = passwordConfirmTextField.text
            if password != confirm {
                alert("两次输入密码不一致")
                return false
            }
            return true
        }
        if checkValid() {
            switch currentStatus {
            case .Artist:
                performSegueWithIdentifier("registerDetail", sender: nil)
            case .Normal:
                // 发送注册信息
                showHUD()
                let parameters = [
                    "user_name": phoneTextField.text,
                    "password": passwordTextField.text,
                    "role": "1" // Magic Number is Magic! ===> 1 表示 普通用户
                ]
                LCYNetworking.sharedInstance.POST(
                    Api: LCYNetworking.LCYApi.UserRegister,
                    parameters: parameters,
                    success: {[weak self] (object) -> Void in
                        let result = object["result"] as? Int
                        if result == 1000 {
                            // 注册成功
                            let userID = object["data"] as Int
                            LCYCommon.sharedInstance.login("\(userID)", nickName: nil, role: "1")
                            self?.navigationController?.popToRootViewControllerAnimated(true)
                        } else {
                            // 注册失败
                            self?.alert(LCYCommon.sharedInstance.errorMessage(result))
                        }
                        self?.hideHUD()
                        return
                    }, fail: { [weak self]() -> Void in
                        self?.hideHUD()
                        return
                })
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        switch section {
        case 0:
            return 3
        case 1:
            return 1
        default:
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: AnyObject!
    
    // Configure the cell...
        switch indexPath.section {
        case 0:
            cell = tableView.dequeueReusableCellWithIdentifier(RegisterTextCell.identifier)
            let cell = cell as RegisterTextCell
            cell.currentType = RegisterTextCell.RegisterTextCellType(rawValue: indexPath.row)!
            switch indexPath.row {
            case 0:
                phoneTextField = cell.icyTextField
            case 1:
                passwordTextField = cell.icyTextField
            case 2:
                passwordConfirmTextField = cell.icyTextField
            default:
                break
            }
        case 1:
            cell = tableView.dequeueReusableCellWithIdentifier(RegisterButtonCell.identifier)
            let cell = cell as RegisterButtonCell
            cell.delegate = self
            cell.currentType = RegisterButtonCell.CellType(rawValue: currentStatus.rawValue)!
        default:
            break
        }
    
        return cell as UITableViewCell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 70.0
    }
    

    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
        if let identifier = segue.identifier {
            switch identifier {
            case "registerDetail":
                let destination = segue.destinationViewController as RegisterArtistDetailViewController
                destination.phoneNumber = phoneTextField.text
                destination.password = passwordTextField.text
            default:
                break
            }
        }
    }

    
}

extension RegisterViewController: RegisterButtonCellDelegate {
    func registerButtonConfirmed() {
        register()
    }
}
