//
//  Animation.swift
//  ParabolaAnimationDemo
//
//  Created by Chakery on 16/2/22.
//  Copyright © 2016年 Chakery. All rights reserved.
//

import UIKit

extension UIView {
    class func animateWithStartView(view: UIView, duration: NSTimeInterval, endPoint: CGPoint, completed: (()->())?) {
        // 开始坐标
        let startX = view.frame.origin.x + view.frame.size.width / 2
        let startY = view.frame.origin.y + view.frame.size.height / 2
        
        // 中心点坐标
        let centerX = startX + (endPoint.x - startX) / 3
        let centerY = startY + (endPoint.y - startY) / 2 - 400
        let centerPoint = CGPoint(x: centerX, y: centerY)
        
        // 路径
        let path = UIBezierPath()
        path.moveToPoint(CGPoint(x: startX, y: startY))
        path.addQuadCurveToPoint(endPoint, controlPoint: centerPoint)
        
        // 动画
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.path = path.CGPath
        animation.removedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        animation.duration = duration
        animation.autoreverses = false
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        view.layer.addAnimation(animation, forKey: "ParabolaAnimation")
    }
}

