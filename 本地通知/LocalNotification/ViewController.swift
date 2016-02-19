//
//  ViewController.swift
//  LocalNotification
//
//  Created by Chakery on 16/2/19.
//  Copyright © 2016年 Chakery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func sendNotification(sender: AnyObject) {
        LocalNotificationManager.sendLocalNotification(title: "aaaa", body: "vvvvvv", delay: 6)
    }

}

