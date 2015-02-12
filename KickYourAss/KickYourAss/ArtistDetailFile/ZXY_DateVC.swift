//
//  ZXY_DateVC.swift
//  KickYourAss
//
//  Created by 宇周 on 15/2/10.
//  Copyright (c) 2015年 多思科技. All rights reserved.
//

import UIKit

class ZXY_DateVC: UIViewController {

    @IBOutlet weak var currentTable: UITableView!
    @IBOutlet weak var bottomTab: UITabBar!
    private var titleList : [Dictionary<String , AnyObject>]!
    private var dataUserID : String!
    private var nameText : String?
    private var sexFlag  : Int?
    private var dateTime : Int?
    private var dateAddress : String?
    private var customPhone : String?
    
    @IBOutlet var datePickerView: UIView!
    
    
    private var valueList : Dictionary<String , AnyObject>? = Dictionary<String , AnyObject>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.startInitTabBar()
        self.title = "预约订单"
        var array  = NSArray(contentsOfFile: NSBundle.mainBundle().pathForResource("orderInfoPList", ofType: "plist")!)
        titleList  = array as [Dictionary<String , AnyObject>]
        currentTable.tableFooterView = UIView(frame:CGRectZero)
        nameText = LCYCommon.sharedInstance.userInfo?.nickName
        titleList.map({[weak self] (temp : Dictionary<String , AnyObject>) -> Void in
            self?.valueList?.extend([temp["title"] as String : ""])
            return
        })
        // Do any additional setup after loading the view.
    }

    func startInitTabBar()
    {
        //self.view.layer.cornerRadius
        bottomTab.items?.map({(item : AnyObject) -> Void in
            var item = item as UITabBarItem
            item.selectedImage = UIImage(named: "tabBarTitle")
            item.image         = UIImage(named: "tabBarTitle")
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUserID(userID : String)
    {
        dataUserID = userID
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if(segue.identifier == "toDateInfoVC")
        {
            //var tagID = sender as Int
            var vc    = segue.destinationViewController as ZXY_DateChangeInfoVC
            vc.delegate = self
            var parameter = sender as Dictionary<String , AnyObject>
            vc.setCurrentTypeDic(parameter)
        }
    }
    

}

extension ZXY_DateVC : UITableViewDelegate , UITableViewDataSource ,UITabBarDelegate
{
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(ZXY_DateVCCellID) as ZXY_DateVCCell
        var currentTitle = titleList[indexPath.row] as Dictionary<String , AnyObject>
        cell.titleLbl.text = currentTitle["title"] as? String
        cell.valueLbl.text = valueList![currentTitle["title"] as String] as? String
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleList.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var currentTitle = titleList[indexPath.row] as Dictionary<String , AnyObject>
        var tagID        = currentTitle["tag"] as Int
        if(tagID == 2)
        {
            self.showTimePicker()
            return
        }
        self.performSegueWithIdentifier("toDateInfoVC", sender: currentTitle)
    }
    
    func showTimePicker()
    {
        self.datePickerView.frame = CGRectMake(0, CGRectGetHeight(self.view.frame), CGRectGetWidth(self.view.frame), CGRectGetHeight(self.datePickerView.frame))
        self.view.addSubview(self.datePickerView)

        
        UIView.animateWithDuration(0.5, animations: {[weak self] () -> Void in
            var superHeight = self?.view.frame.size.height
            var pickerHeight = self?.datePickerView.frame.size.height
            var pickerWidth  = self?.view.frame.size.width
            self?.datePickerView.frame = CGRectMake(0, superHeight! - pickerHeight!,pickerWidth!,pickerHeight!)
            return
        })
    }
    
    func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem!) {
        var myUserID = LCYCommon.sharedInstance.userInfo?.userID
        if(myUserID == nil)
        {
            var story  = UIStoryboard(name: "AboutMe", bundle: nil)
            var vc     = story.instantiateViewControllerWithIdentifier("login") as UIViewController
            self.navigationController?.pushViewController(vc, animated: true)
            return
        }
        if(self.checkInputISValidate())
        {
            MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            var nameString   = self.returnTitle(0)
            var telString    = self.returnTitle(4)
            var addrString   = self.returnTitle(3)
            
            var urlString = ZXY_ALLApi.ZXY_MainAPI + ZXY_ALLApi.ZXY_AddOrderAPI
            var parameter : Dictionary<String , AnyObject> = ["user_id" :dataUserID , "custom_id" : myUserID! , "real_name":nameString , "sex": sexFlag! , "order_time":dateTime! , "tel": telString, "detail_addr": addrString]
            ZXY_NetHelperOperate().startGetDataPost(urlString, parameter: parameter, successBlock: {[weak self] (returnDic) -> Void in
                MBProgressHUD.hideAllHUDsForView(self?.view, animated: true)
                var status = returnDic["result"] as Int
                if(status == 1000)
                {
                    self?.navigationController?.popViewControllerAnimated(true)
                }
                else
                {
                    var errorDic = NSDictionary(contentsOfFile: NSBundle.mainBundle().pathForResource("ErrorMessage", ofType: "plist")!)
                    self?.showAlertEasy("提示", messageContent: errorDic!["\(status)"] as String)
                }
                return
            }, failBlock: {[weak self] (error) -> Void in
                println(error)
                MBProgressHUD.hideAllHUDsForView(self?.view, animated: true)
            })
        }
    }
    
    func checkInputISValidate() -> Bool
    {
        var isValidate : Bool = true
        for (index , value) in enumerate(titleList)
        {
            var titleKey = value["title"] as String
            var valueTemp = valueList![titleKey] as String
            if(valueTemp == "" || valueTemp.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) == 0)
            {
                isValidate = false
                self.showAlertEasy("提示", messageContent: (value["warn"] as String))
                break
            }
        }
        return isValidate
    }
    
    func returnTitle(currentRow : Int) -> String
    {
        var titleDic = titleList[currentRow]
        var titleKey = titleDic["title"] as String
        var titleValue = valueList![titleKey] as String
        return titleValue
    }
    
    
}

extension ZXY_DateVC : ZXY_DateChangeInfoVCDelegate
{
    
    @IBAction func datePickChange(sender: AnyObject) {
        var picker        = sender as UIDatePicker
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm"
        var currentDate   = picker.date as NSDate
        var dateString    = dateFormatter.stringFromDate(currentDate)
        var currentTitle = titleList[2] as Dictionary<String , AnyObject>
        var titleString  = currentTitle["title"] as String
        valueList?.extend([titleString : dateString])
        currentTable.reloadData()
        var stamp = currentDate.timeIntervalSince1970
        dateTime  = Int(stamp)
        println("timeStamp is \(dateTime)")
    }
    
    
    @IBAction func finishPickDate(sender: AnyObject) {
        UIView.animateWithDuration(0.5, animations: { [weak self]() -> Void in
            var superHeight = self?.view.frame.size.height
            var pickerHeight = self?.datePickerView.frame.size.height
            var pickerWidth  = self?.view.frame.size.width
            self?.datePickerView.frame = CGRectMake(0, superHeight!,pickerWidth!,pickerHeight!)
            return
        }) {[weak self] (flag) -> Void in
            self?.datePickerView.removeFromSuperview()
            return
        }
    }
    
    func afterChange(sendKey: String, andValue sendValue: String) {
        valueList?.extend([sendKey : sendValue])
        currentTable.reloadData()
    }
    
    func changeSex(sexFlag: Int) {
        self.sexFlag = sexFlag
        currentTable.reloadData()
    }
}
