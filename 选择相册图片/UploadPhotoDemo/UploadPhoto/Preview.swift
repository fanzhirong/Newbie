//
//  Preview.swift
//  uploadPhoto
//
//  Created by Chakery on 16/2/20.
//  Copyright © 2016年 Chakery. All rights reserved.
//

import UIKit

/// 点击事件
typealias clickBlock = (preview: Preview, image: UIImage, index: Int) -> Void

protocol PreviewDelegate {
	func previewCloseButton(preview: Preview, image: UIImage, index: Int)
}

class Preview: UIView {
	var imageView: UIImageView! // 图片
	var closeButton: UIButton! // 关闭按钮
	var image: UIImage // image
	var imageViewStatus: Bool = false // 图片的显示状态, false 小图, true 大图
	var imageFrame: CGRect // 图片原始位置/大小
	var tap: UITapGestureRecognizer! // 单点手势
	var index: Int! // 图片的标识(第几个图片)
	var block: clickBlock? // 回调
	var delegate: PreviewDelegate? // 代理

	init(frame: CGRect, image: UIImage, index: Int) {
		self.image = image
		self.imageFrame = frame
		self.index = index
		super.init(frame: frame)
		tap = UITapGestureRecognizer(target: self, action: "imageClickEvent:")
		setupView()
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	/// 设置视图
	func setupView() {
		imageView = UIImageView(frame: self.bounds)
		imageView.userInteractionEnabled = true
		imageView.image = image
		imageView.addGestureRecognizer(tap)
		addSubview(imageView)

		closeButton = UIButton(frame: CGRectMake(self.bounds.width - 10, -10, 20, 20))
		closeButton.setImage(UIImage(named: "cgy_close_image"), forState: .Normal)
		closeButton.setImage(UIImage(named: "cgy_close_image"), forState: .Highlighted)
		closeButton.addTarget(self, action: "closeButtonClickEvent", forControlEvents: .TouchUpInside)
		imageView.addSubview(closeButton)
	}

	/// 图片被点击
	func imageClickEvent(tap: UITapGestureRecognizer) {
//		let pvc = PreViewController()
//		let rootVC = UIApplication.sharedApplication().keyWindow?.rootViewController
//		rootVC?.presentViewController(pvc, animated: true, completion: nil)
	}

	/// 关闭按钮
	func closeButtonClickEvent() {
		block?(preview: self, image: image, index: index)
		delegate?.previewCloseButton(self, image: image, index: index)
	}

	/// 解决越界点击问题
	override func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
		if CGRectContainsPoint(closeButton.frame, point) {
			return closeButton
		}
		return super.hitTest(point, withEvent: event)
	}

	/// 点击事件的回调方法
	/// - parameter callback	回调
	func closeButtonDidTouchInside(callback: clickBlock) {
		block = callback
	}
}
