//
//  LCYCareViewController.swift
//  KickYourAss
//
//  Created by eagle on 15/2/10.
//  Copyright (c) 2015年 多思科技. All rights reserved.
//

import UIKit

class LCYCareViewController: UIPageViewController {
    
    @IBOutlet private weak var icySegmentedControl: UISegmentedControl!
    @IBAction func segmentChanged(sender: UISegmentedControl) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let firstViewController = storyboard?.instantiateViewControllerWithIdentifier("careArtist") as LCYCareArtistViewController
        setViewControllers([firstViewController], direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
        delegate = self
        dataSource = self
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

extension LCYCareViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        if viewController is LCYCareNormalViewController {
            let previousViewController = storyboard?.instantiateViewControllerWithIdentifier("careArtist") as? LCYCareArtistViewController
            return previousViewController
        }else {
            return nil
        }
    }
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        if viewController is LCYCareArtistViewController {
            let nextViewController = storyboard?.instantiateViewControllerWithIdentifier("careNormal") as? LCYCareNormalViewController
            return nextViewController
        } else {
            return nil
        }
    }
}
