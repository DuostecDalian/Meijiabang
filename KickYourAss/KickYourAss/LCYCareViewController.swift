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
    
    private weak var artistVC: UIViewController?
    private weak var normalVC: UIViewController?
    
    @IBAction func segmentChanged(sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            let currentVC = viewControllers.first as UIViewController
            if let previous = dataSource?.pageViewController(self, viewControllerBeforeViewController: currentVC) {
                setViewControllers([previous], direction: UIPageViewControllerNavigationDirection.Reverse, animated: true, completion: nil)
            }
        } else {
            let currentVC = viewControllers.first as UIViewController
            if let next = dataSource?.pageViewController(self, viewControllerAfterViewController: currentVC) {
                setViewControllers([next], direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let firstViewController = storyboard?.instantiateViewControllerWithIdentifier("careArtist") as LCYCareArtistViewController
        artistVC = firstViewController
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
            if let artVC = artistVC {
                return artVC
            } else {
                let previousViewController = storyboard?.instantiateViewControllerWithIdentifier("careArtist") as? LCYCareArtistViewController
                artistVC = previousViewController
                return previousViewController
            }
        }else {
            return nil
        }
    }
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        if viewController is LCYCareArtistViewController {
            if let norVC = normalVC {
                return norVC
            } else {
                let nextViewController = storyboard?.instantiateViewControllerWithIdentifier("careNormal") as? LCYCareNormalViewController
                normalVC = nextViewController
                return nextViewController
            }
        } else {
            return nil
        }
    }
    func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [AnyObject], transitionCompleted completed: Bool) {
        if pageViewController.viewControllers.first is LCYCareArtistViewController {
            icySegmentedControl.selectedSegmentIndex = 0
        } else {
            icySegmentedControl.selectedSegmentIndex = 1
        }
    }
}
