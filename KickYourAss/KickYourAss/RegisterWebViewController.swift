//
//  RegisterWebViewController.swift
//  KickYourAss
//
//  Created by eagle on 15/1/28.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

class RegisterWebViewController: UIViewController {

    @IBOutlet weak var icyWebView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let fileURL = NSBundle.mainBundle().URLForResource("register_help", withExtension: "html")!
        let data = NSData(contentsOfURL: fileURL)
        icyWebView.loadData(data, MIMEType: "text/html", textEncodingName: "utf-8", baseURL: nil)
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
