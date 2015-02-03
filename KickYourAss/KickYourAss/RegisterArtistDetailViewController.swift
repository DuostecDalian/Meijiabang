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
