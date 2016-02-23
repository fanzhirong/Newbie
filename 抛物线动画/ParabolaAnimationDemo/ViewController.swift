//
//  ViewController.swift
//  ParabolaAnimationDemo
//
//  Created by Chakery on 16/2/22.
//  Copyright © 2016年 Chakery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let image = UIImage(named: "image")
    let imageView = UIImageView(frame: CGRect(x: 10, y: 100, width: 200, height: 200))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = image
        view.addSubview(imageView)
    }

    @IBAction func addToCart(sender: AnyObject) {
        let rect = UIScreen.mainScreen().bounds
        
        // 终点坐标
        let endPoint = CGPoint(x: rect.width - 30, y: rect.height - 30)
        
        // 开启动画
        UIView.animateWithStartView(imageView, duration: 0.4, endPoint: endPoint, completed: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

