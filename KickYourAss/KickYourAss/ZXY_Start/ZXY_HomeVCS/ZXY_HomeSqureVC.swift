//
//  ZXY_HomeSqureVC.swift
//  KickYourAss
//
//  Created by 宇周 on 15/1/27.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

class ZXY_HomeSqureVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

extension ZXY_HomeSqureVC : UITableViewDelegate, UITableViewDataSource
{
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var currentSection = indexPath.section as Int
        var currentRow     = indexPath.row     as Int
        if(currentSection == 0)
        {
            var cell = tableView.dequeueReusableCellWithIdentifier(ZXY_HomeSqTitleCellID) as ZXY_HomeSqTitleCell
            return cell
        }
        else
        {
            var cell = tableView.dequeueReusableCellWithIdentifier(ZXY_HomeSqContentCellID) as ZXY_HomeSqContentCell
            return cell
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var currentSection = indexPath.section as Int
        var currentRow     = indexPath.row     as Int
        
        if(currentSection == 0)
        {
            return 120
        }
        else
        {
            return 102
        }
    }
}
