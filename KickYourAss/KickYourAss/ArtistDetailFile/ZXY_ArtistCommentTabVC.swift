//
//  ZXY_ArtistCommentTabVC.swift
//  KickYourAss
//
//  Created by 宇周 on 15/1/29.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit
let ZXY_ArtistCommentTabVCID = "artistCommentID"
protocol ZXY_ArtistCommentTabVCDelegate : class
{
    func tableViewDidScroll(collection: UITableView)
}
class ZXY_ArtistCommentTabVC: UIViewController {

    @IBOutlet weak var currentTableV: UITableView!
    
    @IBOutlet weak var noNetView: UIView!
    
    private var dataForShow : NSMutableArray = NSMutableArray()
    
    private var userID : String!
    private var currentPage : Int = 1
    
    var delegate : ZXY_ArtistCommentTabVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var tapReload = UITapGestureRecognizer(target: self, action: Selector("startDownLoadOrderInfo"))
        self.noNetView.addGestureRecognizer(tapReload)
        self.noNetView.userInteractionEnabled = true
        startDownLoadOrderInfo()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setCurrentUserID(userID : String)
    {
        self.userID = userID
    }
    
    func startDownLoadOrderInfo()
    {
        var stringURL = ZXY_ALLApi.ZXY_MainAPI + ZXY_ALLApi.ZXY_UserCommentAPI
        ZXY_NetHelperOperate().startGetDataPost(stringURL, parameter: ["user_id": userID], successBlock: {[weak self] (returnDic) -> Void in
            var returnData = ZXY_UserCommentBase(dictionary: returnDic).data
            if(self?.currentPage == 0)
            {
                self?.dataForShow.removeAllObjects()
                self?.dataForShow.addObjectsFromArray(returnData)
            }
            else
            {
                self?.dataForShow.addObjectsFromArray(returnData)
            }
            self?.currentTableV.reloadData()
        }) {[weak self] (error) -> Void in
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

extension ZXY_ArtistCommentTabVC : UITableViewDataSource , UITableViewDelegate , UIScrollViewDelegate
{
    func reloadDataTable()
    {
        if(dataForShow.count == 0)
        {
            currentTableV.hidden = true
        }
        else
        {
            currentTableV.hidden = false
        }
        currentTableV.reloadData()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(ZXY_ArtistDetailCommentCellID) as ZXY_ArtistDetailCommentCell
        var currentUser : ZXY_UserCommentData = dataForShow[indexPath.row] as ZXY_UserCommentData
        cell.nameLBL.text = currentUser.nickName
        cell.desLbl.text  = currentUser.comment
        cell.headerImg.image = UIImage(named: "search_personCenter")
        var stringURL = ZXY_ALLApi.ZXY_MainAPIImage + currentUser.headImage
        if(currentUser.headImage.hasPrefix("http"))
        {
            stringURL = currentUser.headImage
        }
        cell.headerImg.setImageWithURL(NSURL(string: stringURL))
        cell.timeLbl.text = self.timeStampToDateString(currentUser.ctime)
        cell.setRateValue((currentUser.score as NSString).integerValue)
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 72
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataForShow.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if( self.delegate != nil )
        {
            self.delegate!.tableViewDidScroll(currentTableV)
        }
    }
}
