//
//  Animation.swift
//  ParabolaAnimationDemo
//
//  Created by Chakery on 16/2/22.
//  Copyright © 2016年 Chakery. All rights reserved.
//

import UIKit

extension UIView {
    /**
     抛物线动画
     
     - parameter originView: 做抛物线的对象
     - parameter duration:   时长(秒)
     - parameter endPoint:   终点
     - parameter completed:  回调
     */
    class func animateWithStartView(originView: UIView, duration: NSTimeInterval, endPoint: CGPoint, completed: (()->())?) {
        let view = originView.copyView()
        
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
        UIView.delay(0.01) {
            view.layer.addAnimation(animation, forKey: "ParabolaAnimation")
        }
        UIView.animateWithDuration(duration, animations: { () -> Void in
            var rect = view.frame
            rect.size.height = 10
            rect.size.width = 10
            view.frame = rect
            }) { _ in
                view.removeFromSuperview()
                completed?()
        }
    }
    
    /**
     复制一个view对象
     
     - returns: 赋值得到的新对象
     */
    private func copyView() -> UIView {
        let view = NSKeyedUnarchiver.unarchiveObjectWithData(NSKeyedArchiver.archivedDataWithRootObject(self))! as! UIView
        self.superview?.addSubview(view)
        return view
    }
    
    /**
     延时操作
     
     - parameter duration:  时长(秒)
     - parameter completed: 回调
     */
    private class func delay(duration: NSTimeInterval, completed: ()->Void) {
        let delay = dispatch_time(DISPATCH_TIME_NOW, Int64(duration * Double(NSEC_PER_SEC)))
        dispatch_after(delay, dispatch_get_main_queue()) {
            completed()
        }
    }
}

