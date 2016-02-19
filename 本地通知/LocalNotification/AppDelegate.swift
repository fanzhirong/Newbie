//
//  AppDelegate.swift
//  LocalNotification
//
//  Created by Chakery on 16/2/19.
//  Copyright © 2016年 Chakery. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // 注册本地通知
        registerLocalNotification(application: application)
        //第1种情况, app没开启
        let localnotification = launchOptions?[UIApplicationLaunchOptionsLocalNotificationKey]
        print(localnotification)
        
        
        return true
    }
    
    //当App既将进入后台、锁屏、有电话进来时会触发此事件
    func applicationWillResignActive(application: UIApplication) {
    }

    //当App进入后台时触发此事件
    func applicationDidEnterBackground(application: UIApplication) {
        UIApplication.sharedApplication().cancelAllLocalNotifications()
    }
    
    //当App从后台即将回到前台时触发此事件
    func applicationWillEnterForeground(application: UIApplication) {
    }
    
    //当App变成活动状态时触发此事件
    func applicationDidBecomeActive(application: UIApplication) {
        application.cancelAllLocalNotifications()
        application.applicationIconBadgeNumber = 0
    }
    
    //当App退出时触发此方法，一般用于保存某些特定的数据
    func applicationWillTerminate(application: UIApplication) {
    }
    
    ///	注册本地通知
    func registerLocalNotification(application application: UIApplication) {
        if (UIDevice.currentDevice().systemVersion as NSString).floatValue >= 8 {
            application.registerUserNotificationSettings(UIUserNotificationSettings(forTypes: [.Badge, .Alert, .Sound], categories: nil))
        }
    }
    
    /// 第2,3种情况, app正在前台运行, 或者在后台运行, 用户点击通知消息进入
    func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {
        UIApplication.sharedApplication().cancelAllLocalNotifications()
        print("跳转到指定的界面")
    }
}

