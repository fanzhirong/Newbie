//
//  PreViewController.swift
//  UploadPhotoDemo
//
//  Created by Chakery on 16/2/24.
//  Copyright © 2016年 Chakery. All rights reserved.
//

import UIKit

class PreViewController: UIViewController {
	private var scrollview: UIScrollView!
	private var tap: UITapGestureRecognizer!
	var index: Int = 0
	var datasourceArray: [UIImage] = []

	override func viewDidLoad() {
		super.viewDidLoad()
		guard datasourceArray.count > 0 else { dismissPreview(); return }
		setupView()
	}

	func dismissPreview() {
		self.dismissViewControllerAnimated(true, completion: nil)
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}

	func setupView() {
		// 添加手势
		tap = UITapGestureRecognizer(target: self, action: "dismissPreview")
		view.addGestureRecognizer(tap)

		// 设置scrollview
		let rect = UIScreen.mainScreen().bounds
		scrollview = UIScrollView(frame: rect)
		scrollview.pagingEnabled = true
		scrollview.showsHorizontalScrollIndicator = false
		scrollview.showsVerticalScrollIndicator = false
		scrollview.contentSize = CGSize(width: CGFloat(datasourceArray.count) * rect.width, height: rect.height)
		scrollview.contentOffset = CGPoint(x: CGFloat(index) * rect.width, y: rect.height)
		view.addSubview(scrollview)

		// 添加图片
		for i in 0 ..< datasourceArray.count {
			let imageRect = CGRect(x: CGFloat(i) * rect.width, y: 0, width: rect.width, height: rect.height)
			let imageview = UIImageView(frame: imageRect)
			scrollview.addSubview(imageview)
		}
	}
}
