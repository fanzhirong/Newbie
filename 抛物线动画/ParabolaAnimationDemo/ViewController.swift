//
//  ViewController.swift
//  ParabolaAnimationDemo
//
//  Created by Chakery on 16/2/22.
//  Copyright © 2016年 Chakery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let rect = UIScreen.mainScreen().bounds
        // view
        let startView = UIView(frame: CGRect(x: 50, y: 300, width: 30, height: 30))
        startView.backgroundColor = UIColor.greenColor()
        view.addSubview(startView)
        // 终点坐标
        let endPoint = CGPoint(x: rect.width, y: rect.height)
        // 开启动画
        UIView.animateWithStartView(startView, duration: 0.4, endPoint: endPoint, completed: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}

