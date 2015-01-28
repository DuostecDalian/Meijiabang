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
            cell.delegate = self
            return cell
        }
        else
        {
            var currentSqure : ZXYAlbumSqureRecommendAlbum = nailRecArr[currentRow] as ZXYAlbumSqureRecommendAlbum
            var cell = tableView.dequeueReusableCellWithIdentifier(ZXY_HomeSqContentCellID) as ZXY_HomeSqContentCell
            var urlString = ZXY_ALLApi.ZXY_MainAPIImage + currentSqure.image.cutPath
            cell.titleImage.setImageWithURL(NSURL(string: urlString))
            cell.timeLbl.text = currentSqure.addTime
            cell.desLbl.text  = currentSqure.recommendAlbumDescription
            cell.artistNameLbl.text = currentSqure.nickName
            cell.favNumLbl.text     = currentSqure.agreeCount
            cell.starNumLbl.text    = currentSqure.collectCount
            
            var headString = ZXY_ALLApi.ZXY_MainAPIImage + currentSqure.headImage
            cell.setUserProfile(NSURL(string: headString))
            
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
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var headerV = UIView(frame: CGRectMake(0, 0, self.view.frame.size.width, 50))
        headerV.backgroundColor = UIColor.whiteColor()
        
        var headerL = UILabel(frame: CGRectMake(10, 5, self.view.frame.size.width - 20, 40))
        var imageLineB = UIImageView(frame: CGRectMake(0, 0, self.view.frame.size.width, 5))
        imageLineB.backgroundColor = ZXY_AllColor.SQURE_GRAY_COLOR
        var imageLine = UIImageView(frame: CGRectMake(0, 49, self.view.frame.size.width, 1))
        imageLine.image = UIImage(named: "segLine")
        headerV.addSubview(imageLineB)
        headerV.addSubview(imageLine)
        headerL.textColor = ZXY_AllColor.SEARCH_RED_COLOR
        if(section == 0)
        {
            headerL.text = "最新美甲"
        }
        else
        {
            headerL.text = "推荐美甲"
        }
        headerV.addSubview(headerL)
        return headerV
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}

extension ZXY_HomeSqureVC : ZXY_HomeSqTitleCellDelegate
{
    func clickImageAtIndex(index: Int) {
        println("用户点击了 \(index)")
    }
}
