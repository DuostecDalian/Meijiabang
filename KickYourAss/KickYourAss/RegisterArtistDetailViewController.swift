//
//  RegisterArtistDetailViewController.swift
//  KickYourAss
//
//  Created by eagle on 15/2/3.
//  Copyright (c) 2015年 多思科技. All rights reserved.
//

import UIKit

class RegisterArtistDetailViewController: UIViewController {
    
    var phoneNumber: String!
    var password: String!
    
    private var smallImage: UIImage? {
        didSet {
            cardImageView.image = smallImage
        }
    }
    @IBOutlet private weak var cardImageView: UIImageView!
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var cardNumberTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Action
    @IBAction func idCardButtonPressed(sender: AnyObject) {
        let actionSheet = UIActionSheet(title: nil, delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: nil, otherButtonTitles: "从照片库选取", "拍照")
        actionSheet.showInView(view)
    }
    
    @IBAction func doneButtonPressed(sender: UIButton) {
        func checkVaid() -> Bool{
            // 验证照片
            if smallImage == nil {
                alert("请您上传身份证照片")
                return false
            }
            // 验证真实姓名
            if countElements(nameTextField.text) == 0 {
                alert("请输入您的真实姓名")
                return false
            }
            // 验证身份证号
            let regx = "^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}(\\d|x|X)$"
            let predicate = NSPredicate(format: "SELF MATCHES %@", argumentArray: [regx])
            if !predicate.evaluateWithObject(cardNumberTextField.text) {
                alert("请输入正确的身份证号码")
                return false
            }
            return true
        }
        
        if checkVaid() {
            showHUD()
            // 上传各种信息
            let parameter = [
                "user_name": phoneNumber,
                "password": password,
                "ident_code": cardNumberTextField.text,
                "real_name": nameTextField.text,
                "role": "2"
            ]
            let imageData = UIImageJPEGRepresentation(smallImage, 0.95)
            LCYNetworking.sharedInstance.POSTImage(
                Api: LCYNetworking.LCYApi.UserRegister,
                parameters: parameter,
                imageData: [imageData],
                fileKey: "Filedata[]",
                success: {[weak self] (object) -> Void in
                    let result = object["result"] as? Int
                    if result == 1000 {
                        let userID = object["data"] as Int
                        LCYCommon.sharedInstance.login("\(userID)", nickName: nil, role: "2")
                        (self?.navigationController?.viewControllers.first as? AboutMeViewController)?.refreshHeader()
                        self?.navigationController?.popToRootViewControllerAnimated(true)
                    } else {
                        self?.alert(LCYCommon.sharedInstance.errorMessage(result))
                    }
                    self?.hideHUD()
                    return
                }, fail: { [weak self]() -> Void in
                    self?.alertNetworkFailed()
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

extension RegisterArtistDetailViewController: UIActionSheetDelegate {
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        var sourceType = UIImagePickerControllerSourceType.Camera
        if buttonIndex == 1 {
            // 从照片库选
            sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        } else if buttonIndex == 2 {
            // 拍照
            sourceType = UIImagePickerControllerSourceType.Camera
        } else {
            return
        }
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        presentViewController(imagePicker, animated: true, completion: nil)
    }
}

extension RegisterArtistDetailViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        picker.dismissViewControllerAnimated(true, completion: nil)
        smallImage = UIImage(image: info[UIImagePickerControllerOriginalImage] as UIImage, scaledToFillToSize: CGSize(width: 500.0, height: 500.0))
    }
}
