//
//  ViewController.swift
//  UploadPhotoDemo
//
//  Created by Chakery on 16/2/23.
//  Copyright © 2016年 Chakery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		let rect = UIScreen.mainScreen().bounds
		let myview = UploadPhotoView(frame: CGRect(x: 10, y: 200, width: rect.width - 20, height: 100))
        view.addSubview(myview)
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
}

