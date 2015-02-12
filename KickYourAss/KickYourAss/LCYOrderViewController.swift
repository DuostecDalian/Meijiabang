//
//  LCYOrderViewController.swift
//  KickYourAss
//
//  Created by eagle on 15/2/11.
//  Copyright (c) 2015年 多思科技. All rights reserved.
//

import UIKit

class LCYOrderViewController: UIPageViewController {
    
    private let userID = LCYCommon.sharedInstance.userInfo!.userID
    private let isArtist = LCYCommon.sharedInstance.userInfo!.role == "2"

    
    private weak var toMeVC: LCYOrderToMeViewController?
    private weak var fromMeVC: LCYOrderFromMeViewController?
    
    
    private weak var segmentedControl: UISegmentedControl?
    func segmentedChanged(sender: UISegmentedControl) {
        if isArtist {
            if sender.selectedSegmentIndex == 0 {
                let toVC = toMeVC ?? storyboard?.instantiateViewControllerWithIdentifier("orderToMe") as LCYOrderToMeViewController
                toMeVC = toVC
                setViewControllers([toVC], direction: UIPageViewControllerNavigationDirection.Reverse, animated: true, completion: nil)
            } else {
                let toVC = fromMeVC ?? storyboard?.instantiateViewControllerWithIdentifier("orderFromMe") as LCYOrderFromMeViewController
                fromMeVC = toVC
                setViewControllers([toVC], direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if isArtist {
            let seg = UISegmentedControl(items: ["预约我的", "我预约的"])
            seg.selectedSegmentIndex = 0
            seg.addTarget(self, action: "segmentedChanged:", forControlEvents: UIControlEvents.ValueChanged)
            segmentedControl = seg
            navigationItem.titleView = seg
            
            let firstVC = storyboard?.instantiateViewControllerWithIdentifier("orderToMe") as LCYOrderToMeViewController
            toMeVC = firstVC
            setViewControllers([firstVC], direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
        } else {
            navigationItem.title = "我的订单"
            
            let firstVC = storyboard?.instantiateViewControllerWithIdentifier("orderFromMe") as LCYOrderFromMeViewController
            setViewControllers([firstVC], direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
        }
        
        dataSource = self
        delegate = self
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

extension LCYOrderViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        if isArtist {
            if viewController is LCYOrderToMeViewController {
                if let fromVC = fromMeVC {
                    return fromVC
                } else {
                    fromMeVC = storyboard?.instantiateViewControllerWithIdentifier("orderFromMe") as? LCYOrderFromMeViewController
                    return fromMeVC
                }
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        if isArtist {
            if viewController is LCYOrderFromMeViewController {
                if let toVC = toMeVC {
                    return toVC
                } else {
                    toMeVC = storyboard?.instantiateViewControllerWithIdentifier("orderToMe") as? LCYOrderToMeViewController
                    return toMeVC
                }
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
    func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [AnyObject], transitionCompleted completed: Bool) {
        if isArtist {
            if pageViewController.viewControllers.first is LCYOrderToMeViewController {
                segmentedControl?.selectedSegmentIndex = 0
            } else {
                segmentedControl?.selectedSegmentIndex = 1
            }
        }
    }
}
