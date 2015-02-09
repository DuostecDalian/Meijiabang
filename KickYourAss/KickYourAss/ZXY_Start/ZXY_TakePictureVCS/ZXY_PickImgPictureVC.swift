//
//  ZXY_PickImgPictureVC.swift
//  KickYourAss
//
//  Created by 宇周 on 15/2/9.
//  Copyright (c) 2015年 多思科技. All rights reserved.
//

import UIKit

protocol ZXY_PickImgPictureVCDelegate : class
{
    func deletePhoto()
}

class ZXY_PickImgPictureVC: UIViewController {

    @IBOutlet weak var currentImgV: UIImageView!
    var thisImage : UIImage!
    
    weak var delegate : ZXY_PickImgPictureVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentImgV.image = thisImage
        self.setNaviBarLeftImage("backArrow")
        self.setNaviBarRightImage("trashImg")
        self.navigationController?.navigationBar.barTintColor = UIColor.blackColor()
        self.title = "1/1"
        // Do any additional setup after loading the view.
    }

    func setCurrentImage(currentImg : UIImage)
    {
        thisImage = currentImg
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.navigationBar.barTintColor = ZXY_AllColor.SEARCH_RED_COLOR
    }
    
    override func rightNaviButtonAction() {
        if(self.delegate != nil)
        {
            self.delegate?.deletePhoto()
        }
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
