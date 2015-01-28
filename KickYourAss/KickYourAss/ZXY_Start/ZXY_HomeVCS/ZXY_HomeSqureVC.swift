//
//  ZXY_HomeSqureVC.swift
//  KickYourAss
//
//  Created by 宇周 on 15/1/27.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

class ZXY_HomeSqureVC: UIViewController {

    @IBOutlet weak var currentTable: UITableView!
    private var nailNewArr : NSMutableArray = NSMutableArray()
    private var nailRecArr : NSMutableArray = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.startDownLoadData()
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startDownLoadData()
    {
        var urlString = ZXY_ALLApi.ZXY_MainAPI + ZXY_ALLApi.ZXY_AlbumSquAPI
        ZXY_NetHelperOperate.sharedInstance.startGetDataPost(urlString, parameter: nil, successBlock: {[weak self] (returnDic) -> Void in
            var squreBaseData : ZXYAlbumSqureBaseClass = ZXYAlbumSqureBaseClass(dictionary: returnDic)
            var squreData : ZXYAlbumSqureData    = squreBaseData.data
            self?.nailRecArr        = NSMutableArray(array: squreData.recommendAlbum)
            self?.nailNewArr        = NSMutableArray(array: squreData.lastAlbum)
            self?.reloadTableData()
        }) { (error) -> Void in
            println(error)
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

extension ZXY_HomeSqureVC : UITableViewDelegate, UITableViewDataSource
{
    func reloadTableData()
    {
        currentTable.reloadData()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var currentSection = indexPath.section as Int
        var currentRow     = indexPath.row     as Int
        if(currentSection == 0)
        {
            var cell = tableView.dequeueReusableCellWithIdentifier(ZXY_HomeSqTitleCellID) as ZXY_HomeSqTitleCell
            cell.setTitleCellLableAndImg(self.nailNewArr)
            return cell
        }
        else
        {
            var cell = tableView.dequeueReusableCellWithIdentifier(ZXY_HomeSqContentCellID) as ZXY_HomeSqContentCell
            return cell
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0)
        {
            if(nailNewArr.count > 0)
            {
                return 1
            }
            return 0
        }
        else
        {
            return nailRecArr.count
        }
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
