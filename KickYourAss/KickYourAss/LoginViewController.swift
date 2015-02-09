//
//  LoginViewController.swift
//  KickYourAss
//
//  Created by eagle on 15/1/21.
//  Copyright (c) 2015年 Li Chaoyi. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet private weak var phoneNumberTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.hidden = false

    }
    
    // MARK: - Actions
    
    @IBAction func confirmButtonPressed(sender: AnyObject) {
        func checkValid() -> Bool {
            let phoneNumber = phoneNumberTextField.text
            let password = passwordTextField.text
            
            // 验证电话号码
            let regx = "^1[3458]\\d{9}$"
            let predicate = NSPredicate(format: "SELF MATCHES %@", argumentArray: [regx])
            if !predicate.evaluateWithObject(phoneNumber) {
                alert("请输入正确的手机号码")
                return false
            }
            // 验证密码
            if countElements(password) < 6 {
                alert("请输入至少6位的密码")
                return false
            }
            
            return true
        }
        
        if checkValid() {
            // 验证成功，发送登录请求
            let phoneNumber = phoneNumberTextField.text
            let password = passwordTextField.text
            
            showHUD()
            LCYNetworking.sharedInstance.POST(
                Api: LCYNetworking.LCYApi.UserLogin,
                parameters: ["user_name": phoneNumber, "password": password],
                success: { [weak self](object) -> Void in
                    let retrieved = CYMJUserLoginBase.modelObjectWithDictionary(object)
                    if retrieved.result == 1000 {
                        LCYCommon.sharedInstance.login(retrieved.data.userId, nickName: retrieved.data.nickName, role: retrieved.data.role)
                        (self?.navigationController?.viewControllers.first as? AboutMeViewController)?.refreshHeader()
                        self?.navigationController?.popToRootViewControllerAnimated(true)
                    } else {
                        self?.alert(LCYCommon.sharedInstance.errorMessage(retrieved.result))
                    }
                    self?.hideHUD()
                    return
            }, fail: { [weak self]() -> Void in
                self?.hideHUD()
                return
            })
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension LoginViewController: UITextFieldDelegate {
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if textField == phoneNumberTextField {
            if range.location >= 11 {
                return false
            }
        }
        return true
    }
}
