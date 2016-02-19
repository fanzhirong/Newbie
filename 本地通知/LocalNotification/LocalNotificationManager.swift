//
//  LocalNotificationManager.swift
//  LocalNotification
//
//  Created by Chakery on 16/2/19.
//  Copyright © 2016年 Chakery. All rights reserved.
//

import UIKit

class LocalNotificationManager {
    ///	发送本地通知
    ///	- parameter title	标题
    ///	- parameter body	内容
    ///	- parameter delay	延时
    class func sendLocalNotification(title title: String, body: String, delay: NSTimeInterval) {
        let delay = dispatch_time(DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC)))
        dispatch_after(delay, dispatch_get_main_queue()) {
            
            let notification = UILocalNotification()
            notification.timeZone = NSTimeZone.localTimeZone()
            notification.repeatInterval = NSCalendarUnit.Day
            notification.alertTitle = title
            notification.alertBody = body
            notification.soundName = UILocalNotificationDefaultSoundName
            //图片显示一个小红点 1
            notification.applicationIconBadgeNumber = 1
            //发送通知
            UIApplication.sharedApplication().presentLocalNotificationNow(notification)
        }
    }
}