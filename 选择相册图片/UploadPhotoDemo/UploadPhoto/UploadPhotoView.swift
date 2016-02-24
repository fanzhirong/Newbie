
//
//  UploadPhotoView.swift
//  UploadPhotoDemo
//
//  Created by Chakery on 16/2/23.
//  Copyright © 2016年 Chakery. All rights reserved.
//

import UIKit

class UploadPhotoView: UIView {
	private var pickerViewControl: UIImagePickerController!
	private var scrollView: UIScrollView! // 滚动视图
	private var photoButton: UIButton! // 添加按钮
	private var photoNumber: Int! // 照片数量
	private var photoArray: [UIImage]! // 照片数组
	private var photoWidth: CGFloat! // 照片宽度
	private var photoHeight: CGFloat! // 照片高度

	override init(frame: CGRect) {
		super.init(frame: frame)
		didInit()
		setupView()
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	/**
	 初始化数据
	 */
	private func didInit() {
		photoArray = []
		photoNumber = 0
		photoWidth = (self.bounds.width - 60) / 5
		photoHeight = self.bounds.height - 20
	}

	/**
	 设置view
	 */
	private func setupView() {
		self.layer.borderColor = UIColor.grayColor().CGColor
		self.layer.borderWidth = 0.5
		scrollView = UIScrollView(frame: self.bounds)
		scrollView.showsHorizontalScrollIndicator = false
		scrollView.showsVerticalScrollIndicator = false
		photoButton = UIButton(frame: CGRect(x: 10, y: 10, width: photoWidth, height: photoHeight))
		photoButton.setBackgroundImage(UIImage(named: "uoloadButton"), forState: .Normal)
		photoButton.addTarget(self, action: "uploadButtonHandle", forControlEvents: .TouchUpInside)

		addSubview(scrollView)
		scrollView.addSubview(photoButton)

		pickerViewControl = UIImagePickerController()
		pickerViewControl.sourceType = .PhotoLibrary
		pickerViewControl.delegate = self
		pickerViewControl.allowsEditing = true
	}

	/**
	 上传按钮
	 */
	func uploadButtonHandle() {
		let rootvc = UIApplication.sharedApplication().keyWindow?.rootViewController
		rootvc?.presentViewController(pickerViewControl, animated: true, completion: nil)
	}

	/**
	 显示图片
	 */
	private func drawPhotoToView() {
		changePhotoButtonFrame()
		guard photoArray.count > 0 else { return }
		// 移除之前的view
		let views = scrollView.subviews
		let _ = views.map {
			if $0.isMemberOfClass(Preview.self) {
				$0.removeFromSuperview()
			}
		}
		// 设置scrollview的内容大小
		scrollView.contentSize = CGSize(width: 10 + photoWidth + CGFloat(photoWidth + 10) * CGFloat(photoArray.count), height: 0)
		// 创建图片
		for i in 0 ..< photoArray.count {
			let rect = CGRect(x: 10 + CGFloat(photoWidth + 10) * CGFloat(i), y: 10, width: photoWidth, height: photoHeight)
			let preview = Preview(frame: rect, image: photoArray[i], index: i)
			preview.delegate = self
			scrollView.addSubview(preview)
		}
	}

	/**
	 移动 photoButton frame
	 */
	private func changePhotoButtonFrame() {
		var rect = photoButton.frame
		rect.origin.x = 10 + CGFloat(photoWidth + 10) * CGFloat(photoArray.count)
		photoButton.frame = rect
	}
}

// MARK: - PreviewDelegate
extension UploadPhotoView: PreviewDelegate {
	func previewCloseButton(preview: Preview, image: UIImage, index: Int) {
		preview.removeFromSuperview()
		photoArray.removeAtIndex(index)
		drawPhotoToView()
	}
}

// MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension UploadPhotoView: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
	func imagePickerControllerDidCancel(picker: UIImagePickerController) {
		pickerViewControl.dismissViewControllerAnimated(true, completion: nil)
	}

	func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
		let type = info[UIImagePickerControllerMediaType] as! String

		if type == "public.image" {
			let image = info[UIImagePickerControllerEditedImage] as! UIImage
			photoArray.append(image)
			self.drawPhotoToView()
		}

		pickerViewControl.dismissViewControllerAnimated(true, completion: nil)
	}
}
