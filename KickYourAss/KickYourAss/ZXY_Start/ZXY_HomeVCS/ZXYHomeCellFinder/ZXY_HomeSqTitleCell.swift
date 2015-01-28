//
//  ZXY_HomeSqTitleCell.swift
//  KickYourAss
//
//  Created by 宇周 on 15/1/27.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit
let ZXY_HomeSqTitleCellID = "ZXY_HomeSqTitleCellID"
protocol ZXY_HomeSqTitleCellDelegate : class
{
    func clickImageAtIndex(index : Int)
}

class ZXY_HomeSqTitleCell: UITableViewCell {

    weak var delegate : ZXY_HomeSqTitleCellDelegate?
    
    @IBOutlet var titleImage: [UIImageView]!
    
    @IBOutlet var imageName: [UILabel]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setTitleCellLableAndImg(arr: NSMutableArray)
    {
        
        for var i = 0 ; i < imageName.count ;i++
        {
            var label : UILabel = imageName[i]
            label.text = ""
            var images : UIImageView = titleImage[i]
            images.backgroundColor = UIColor.clearColor()
            images.image = nil
        }
        if(arr.count > 4)
        {
            for var i = 0 ; i < imageName.count ;i++
            {
                var recTemp : ZXYAlbumSqureLastAlbum = arr[i] as ZXYAlbumSqureLastAlbum
                var label : UILabel = imageName[i]
                var textString : NSString = recTemp.lastAlbumDescription as NSString
                if(textString.length > 5)
                {
                    label.text = textString.substringToIndex(5)
                }
                else
                {
                    label.text = textString
                }
                var images : UIImageView = titleImage[i]
                images.backgroundColor = UIColor.clearColor()
                var stringURL = ZXY_ALLApi.ZXY_MainAPIImage + recTemp.image.cutPath
                images.setImageWithURL(NSURL(string: stringURL))
            }
        }
        else
        {
            for var i = 0 ; i < arr.count ; i++
            {
                var recTemp : ZXYAlbumSqureLastAlbum = arr[i] as ZXYAlbumSqureLastAlbum
                var label : UILabel = imageName[i]
                var textString : NSString = recTemp.lastAlbumDescription as NSString
                if(textString.length > 5)
                {
                    label.text = textString.substringToIndex(5)
                }
                else
                {
                    label.text = textString
                }
                var images : UIImageView = titleImage[i]
                images.backgroundColor = UIColor.clearColor()
                var stringURL = ZXY_ALLApi.ZXY_MainAPIImage + recTemp.image.cutPath
                images.setImageWithURL(NSURL(string: stringURL))
            }
        }
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        var touch : UITouch = touches.anyObject() as UITouch
        var point : CGPoint = touch.locationInView(self)
        for var i = 0; i < titleImage.count ; i++
        {
            var currentImage = titleImage[i]
            if(CGRectContainsPoint(currentImage.frame, point))
            {
                if(self.delegate != nil)
                {
                    self.delegate?.clickImageAtIndex(i)
                    return
                }
            }
        }
        
        
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        
        
    }
}
