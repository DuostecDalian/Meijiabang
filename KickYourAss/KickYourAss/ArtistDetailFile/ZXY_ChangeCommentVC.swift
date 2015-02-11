//
//  ZXY_ChangeCommentVC.swift
//  KickYourAss
//
//  Created by 宇周 on 15/2/10.
//  Copyright (c) 2015年 多思科技. All rights reserved.
//

import UIKit

class ZXY_ChangeCommentVC: UIViewController {

    @IBOutlet weak var commentTextF: UITextField!
    
    var albumDes : String?
    var albumID  : String?
    var albumDetail : ZXY_PictureDetailBase?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNaviBarLeftImage("backArrow")
        self.title = "编辑图集"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "发送", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("rightButtonAction"))
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if(self.albumDes != nil)
        {
            self.commentTextF.text = albumDes!
            self.commentTextF.becomeFirstResponder()
        }
        else
        {
            self.commentTextF.becomeFirstResponder()
        }
    }

    func rightButtonAction()
    {
        if(self.albumID == nil)
        {
            self.navigationController?.popViewControllerAnimated(true)
            return
        }
        else
        {
            if(self.commentTextF.text.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) == 0)
            {
                self.showAlertEasy("提示", messageContent: "介绍不能为空")
                return
            }
            var stringURL = ZXY_ALLApi.ZXY_MainAPI + ZXY_ALLApi.ZXY_ModifyAlbumAPI
            var parameter : Dictionary<String , AnyObject> = ["album_id": albumID! , "description": self.commentTextF.text]
            MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            ZXY_NetHelperOperate().startGetDataPost(stringURL, parameter: parameter, successBlock: {[weak self] (returnDic) -> Void in
                MBProgressHUD.hideAllHUDsForView(self?.view, animated: true)
                self?.albumDetail?.data?.dataDescription = self?.commentTextF.text
                self?.navigationController?.popViewControllerAnimated(true)
                return
            }, failBlock: { [weak self] (error) -> Void in
                MBProgressHUD.hideAllHUDsForView(self?.view, animated: true)
                self?.showAlertEasy("提示", messageContent: "修改失败")
            })
        }
    }
    
    func setAlbumID(albumDetail : ZXY_PictureDetailBase?)
    {
        self.albumID = albumDetail?.data?.albumId?
        self.albumDes = albumDetail?.data?.dataDescription?
        self.albumDetail = albumDetail
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
