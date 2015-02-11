//
//  ZXY_DateChangeInfoVC.swift
//  KickYourAss
//
//  Created by 宇周 on 15/2/10.
//  Copyright (c) 2015年 多思科技. All rights reserved.
//

import UIKit

@objc protocol ZXY_DateChangeInfoVCDelegate : class
{
    func afterChange(sendKey : String , andValue sendValue: String)
    optional func changeSex(sexFlag : Int)
}


class ZXY_DateChangeInfoVC: UIViewController {

    @IBOutlet weak var currentTable: UITableView!
    private var infoText : UITextField?
    
    weak var delegate : ZXY_DateChangeInfoVCDelegate?
    
    var currentDic : Dictionary<String , AnyObject>!
    
    var isInput    : Bool = true
    
    var sexFlag    = 1
    
    var sexString  = "男"
    
    func setCurrentTypeDic(valueDic : Dictionary<String , AnyObject>)
    {
        currentDic = valueDic
        var flag   = currentDic["tag"] as Int
        if(flag == 1)
        {
            isInput = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "填写信息"
        self.setNaviBarRightImage("rightSimple")
        self.setNaviBarLeftImage("backArrow")
        currentTable.tableFooterView = UIView(frame: CGRectZero)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func rightNaviButtonAction() {
        var keyString   = currentDic["title"] as String
        if(self.delegate != nil)
        {
            if(isInput)
            {
                self.delegate!.afterChange(keyString, andValue: infoText!.text)
            }
            else
            {
                self.delegate!.afterChange(keyString, andValue:sexString)
                self.delegate!.changeSex!(sexFlag)
            }
        }
        self.navigationController?.popViewControllerAnimated(true)
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

extension ZXY_DateChangeInfoVC : UITableViewDelegate ,UITableViewDataSource
{
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if(isInput)
        {
            var cell = tableView.dequeueReusableCellWithIdentifier(ZXY_ChangeDateInfoCellID) as ZXY_ChangeDateInfoCell
            self.infoText = cell.infoText
            return cell
        }
        else
        {
            var cell = tableView.dequeueReusableCellWithIdentifier(ZXY_ChangeUserSexCellID) as ZXY_ChangeUserSexCell
            cell.userSelectBoyOrGirlBlock = {[weak self](flag) -> Void in
                self?.sexFlag = flag
                if(flag == 1)
                {
                    self?.sexString = "男"
                }
                else
                {
                    self?.sexString = "女"
                }
                return
            }
            
            return cell
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if(isInput)
        {
            return 72
        }
        else
        {
            return 181
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
}
