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

extension ZXY_DateVC : UITableViewDelegate , UITableViewDataSource
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
    }
    
    func changeSex(sexFlag: Int) {
        self.sexFlag = sexFlag
    }
}
